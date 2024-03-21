---
title: "Next.jsのssgでffmpeg.wasmがブラウザだけで動作するサイトをcloudflareにデプロイしてみた"
excerpt: "みなさんこんにちは、かじりです。Next.jsでffmpeg.wasmを使ってcloudflareにデプロイしようとしたらSharedArrayBufferとかで色々詰まったのでまとめてみました。"
coverImage: "/assets/blog/using-ffmpeg-wasm-with-nextjs/cover.png"
date: "2021-09-26 23:28:07"
author:
  name: かじり
  picture: "/me.jpg"
ogImage:
  url: "/ogp/1200x630.png"
category:
  first: javascript
  second: wasm
tags: [javascript, nextjs, wasm, cloudflare, shared-array-buffer]
---

# Next.jsのssgでffmpeg.wasmがブラウザだけで動作するサイトをcloudflareにデプロイしてみた

みなさんこんにちは、かじりです。Next.jsのssgでffmpeg.wasmがブラウザだけで動作するサイトをcloudflareにデプロイしてみた時の知見を共有します。簡単に言うとSharedArrayBufferを使えるようにする必要があり、serverがresponse headerに必要な情報を付加する必要があります。そこらへんをまとめました。

記事執筆時点のgithubのソースは[こちら](https://github.com/kajirikajiri/ffmpeg-wasm/tree/345d09412144500f67d5da37b3eafb4b2a94c1b2/pages)のコミットです。


## 大まかな概要

[こちら](https://github.com/ffmpegwasm/ffmpeg.wasm)がffmpeg.wasmの公式githubになります。こちらのサイトから引用すると

>SharedArrayBuffer is only available to pages that are cross-origin isolated. So you need to host your own server with Cross-Origin-Embedder-Policy: require-corp and Cross-Origin-Opener-Policy: same-origin headers to use ffmpeg.wasm.
>>SharedArrayBufferはCross-Originで隔離されたページでしか利用できません。そのため、ffmpeg.wasmを使用するには、Cross-Origin-Embedder-Policy: require-corpとCross-Origin-Opener-Policy: Same-originのヘッダーを持つ独自のサーバーをホストする必要があります。

このように書いてあります。つまり、独自のサーバーをホストし、ヘッダーでCross-Origin-Embedder-Policy: require-corpとCross-Origin-Opener-Policy: Same-originを返す必要があります。

また、以下の引用にあるように、browserではscriptタグを使用してください。と書いてあります。

>Or, using a script tag in the browser (only works in some browsers, see list below):
>>または、ブラウザのscriptタグを使用する方法（一部のブラウザでのみ動作します、以下のリストをご参照ください）。

なのでscriptタグを使用してffmpeg.wasmを読み込みたいのですが、サーバーからCross-Origin-Embedder-Policy: require-corpとCross-Origin-Opener-Policy: Same-originをresponse headerとして返すと、scriptタグを使用して他のoriginからソースの読み込みができません。つまり、以下のような読み込みができません。例で言うと、私のサイトはkajiri.devと言うoriginなので、unpkg.comにホストされたファイルはscriptタグで読み込むことができません。

```javascript
<script src="https://unpkg.com/@ffmpeg/ffmpeg@0.10.1/dist/ffmpeg.min.js"/>
```

上記scriptタグをソースコードに記載すると、以下のようなエラーが出ました。

GET https://unpkg.com/@ffmpeg/ffmpeg@0.10.1/dist/ffmpeg.min.js net::ERR_BLOCKED_BY_RESPONSE.NotSameOriginAfterDefaultedToSameOriginByCoep 200

今までのところをまとめると、

- ブラウザでffmpeg.wasmを使用するにはscriptタグでffmpeg.wasmを読み込む必要がある。
- かつ、SharedArrayBufferを使用するためにresponse headerでCross-Origin-Embedder-Policy: require-corpとCross-Origin-Opener-Policy: Same-originを返す必要がある。と言うことになります。

## 一時的に回避する

とはいえ、いきなり上記の対応をするのが辛いこともあると思います。なので、[googleのサイト](https://developer.chrome.com/origintrials/#/register_trial/303992974847508481)で申請を出して、[googleのサイトの説明](https://developer.chrome.com/blog/enabling-shared-array-buffer/#origin-trial)に書いてあるように設定をすれば、「The exception expires in Chrome 96, and the exception only applies to Desktop Chrome」とあるので、Chrome96で期限切れになるまでは一時的に回避できるようです。私も試しに申請してみたのですが、SharedArrayBufferが使えるようになりました。


## localhostで動くようにする

ではlocalhostで動くようにしましょう。

### response headerを設定する
先ほど書いたようにresponse headerをサーバーから返す必要があります。Next.jsにはカスタムサーバーを設定する機能があるので、server.jsと言うファイルを作成します。

```javascript
// server.js
const { createServer } = require('http')
const { parse } = require('url')
const next = require('next')

const dev = process.env.NODE_ENV !== 'production'
const app = next({ dev })
const handle = app.getRequestHandler()

app.prepare().then(() => {
  createServer((req, res) => {
    const parsedUrl = parse(req.url, true)
    const { pathname, query } = parsedUrl

    res.setHeader('Cross-Origin-Embedder-Policy', 'require-corp')
    res.setHeader('Cross-Origin-Opener-Policy', 'same-origin')
    handle(req, res, parsedUrl)
  }).listen(3000, (err) => {
    if (err) throw err
    console.log('> Ready on http://localhost:3000')
  })
})
```

上記のように設定した後に、server.jsをnodeで起動します。

```bash
node server.js
```

詳しくは[Next.jsのサイト](https://nextjs.org/docs/advanced-features/custom-server)に記載されています。

上記のようにnode server.jsで起動することでサーバーからCross-Origin-Embedder-Policy: require-corpとCross-Origin-Opener-Policy: Same-originがresponse headerとして返ります。

### scriptタグでffmpeg.wasmを読み込む

https://unpkg.com/@ffmpeg/ffmpeg@0.10.1/dist/ffmpeg.min.js

上記サイトにアクセスして、jsのファイルとして内容を保存しましょう。ここではffmpeg.jsとします。そして、scriptタグで読み込みます。

```javascript
<script src="ffmpeg.js"/>
```

最近のNext.jsはScriptタグがあるのでそれでも良いです。その場合こうなります。

```javascript
<Script strategy="beforeInteractive" src="ffmpeg.js" />
```

上記どちらかで設定すれば、ffmpeg.wasmが動くと思います。

私のソースコードは[こちら](https://github.com/kajirikajiri/ffmpeg-wasm/blob/345d09412144500f67d5da37b3eafb4b2a94c1b2/pages/index.tsx#L73)です。

## productionで動くようにする

私の場合、ssgで動かしたので、それを記載します。

### scriptタグでffmpeg.wasmを読み込む

ここはlocalhostと一緒なのでこのページの上の方を参考にしてください。

### response headerを設定する

response headerを設定するために、cloudflare workersを使用します。cloudflare workersの使い方は省略しますが、workerには次のコードを設定します。

```javascript
addEventListener('fetch', event => {
  event.respondWith(handleRequest(event.request))
})

async function handleRequest(request) {

  let originalResponse = await fetch(request)

  let response = new Response(originalResponse.body,originalResponse);

  response.headers.set('Cross-Origin-Embedder-Policy', 'require-corp');
  response.headers.set('Cross-Origin-Opener-Policy','same-origin');

  return response
}
```

これで、response headerにCross-Origin-Embedder-Policy: require-corpとCross-Origin-Opener-Policy: Same-originが設定されるので、SharedArrayBufferが使用できるようになりました。

---

ちょっと前にvim.wasmを使ってみようとして、SharedArrayBufferがうまく使えなかったのですが、今回はffmpeg.wasmに挑戦してみたところうまくいきました。[デプロイ](https://wasm.kajiri.dev/)しましたので、動画ファイルをuploadしてgifに変換してみてください。(リンク先の変更で消えてたらごめんなさい)。サンプルの動画ファイルはffmpeg.wasmが準備している[こちら](https://github.com/ffmpegwasm/testdata)を使用できると思います。
