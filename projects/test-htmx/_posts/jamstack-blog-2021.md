---
title: "Next.jsでJamstackなblogを作った"
excerpt: "みなさんこんにちは、かじりです。Jamstackを使ってブログを作成してみました。Jamstackのおかげで爆速なブログが完成しました。lighthouseの評価も90点以上で満足です。"
coverImage: "/assets/blog/jamstack-blog-2021/cover.svg"
date: "2021-05-04 17:35:41"
author:
  name: かじり
  picture: "/me.jpg"
ogImage:
  url: "/ogp/1200x630.png"
category:
  first: blog
  second: jamstack
tags: [blog, jamstack, nextjs, d3js]
---

# Next.jsでJamstackなblogを作った

みなさんこんにちは、かじりです。[Jamstack](https://jamstack.org/), [Next.js](https://nextjs.org/), [D3.js](https://d3js.org/), [Materil-ui](https://material-ui.com/), [remarkjs](https://github.com/remarkjs/remark)で[このblog](https://kajiri.dev/)を作成しました。[AMP](https://amp.dev/)対応も試みたんですが、見た目が好みじゃなかったんでやめましたｗ


## Jamstackとは

[jamstack.org](https://jamstack.org/)に特徴が書いてありました。

> Jamstackは、ウェブの新しい標準アーキテクチャです。Gitワークフローと最新のビルドツールを用いて、プリレンダリングされたコンテンツをCDNに配信し、APIやサーバーレス機能によってダイナミックにします。スタックを構成するテクノロジーには、JavaScriptフレームワーク、Static Site Generator、ヘッドレスCMS、CDNなどがあります。

SPAだと、[reactjs.org](https://ja.reactjs.org/docs/glossary.html)に書いてました

> シングルページアプリケーション (single-page application) は、単一の HTML ページでアプリケーションの実行に必要なすべてのアセット（JavaScript や CSS など）をロードするようなアプリケーションです。初回ページもしくはそれ以降のページでのユーザとのやりとりにおいて、サーバとの往復が不要、すなわちページのリロードが発生しません。

ただ、[stackoverflowのある回答](https://stackoverflow.com/a/61628508)によると、以前まではJamstackでなく、JAMstackという表記だったそうです。

> 昔の定義を見て、非常に純粋に考えれば、SPAはこのカテゴリーに入ることができます。定義がJAM(JavaScript, Apis, Markup)からJam(a mix of tech)に移ったのもそのためでしょう。

どうやら以前までの定義ではSPAはJAMstackに入るらしく、それで様々なテクノロジーを使うJamという表現に変わったようで、Jamstackというのは定義が曖昧なものだと思っていますが、**個人的には事前にビルドされた静的なファイルをデプロイするやつ**だと思ってます。

## Next.jsでJamstackを使う

[vercel/next.jsのexampleリポジトリ](https://github.com/vercel/next.js/tree/canary/examples/blog-starter-typescript)でサンプルが配布されています。今回はこれを元にサイトを作りました。

まずデプロイするために[cloudflareのnextjsのsample](https://developers.cloudflare.com/pages/how-to/deploy-a-nextjs-site)も見たところ、buildコマンドは`next build && next export` となっており、またビルドの構成画面をみるにstartコマンドの登録箇所が無いです。

![cloudflare-build構成画面](assets/blog/jamstack-blog-2021/cloudflare-build.png)

ないので、[vercel/next.jsのexampleリポジトリ](https://github.com/vercel/next.js/tree/canary/examples/blog-starter-typescript)のbuildコマンドを`next build`から[cloudflareのnextjsのsample](https://developers.cloudflare.com/pages/how-to/deploy-a-nextjs-site)とおなじように、`next build && next exoprt`に変更しました

これでデプロイしたところとりあえずうごいいたので満足です。
ついでに大事に3日くらい温めておいたドメインを使いました。

## domainの購入

[お名前.com](https://www.onamae.com/service/d-price/)だと**2,178円**
[googleDomains](https://domains.google/intl/ja_jp/)だと**1400円**

ドメインによって値段違うだろうし、税込み税抜とか調べて無いですが、まあ[googleDomains](https://domains.google/intl/ja_jp/)で買いましょう。細かく調べて無いですが。更新料も毎年そのまま取られるんで、2178\*nと1400\*nだと長年使うとデカイですね。

[googleDomains](https://domains.google/intl/ja_jp/)のUIは新しい感じで個人的に好みです。

## materil-uiを設定する

[vercel/next.jsのexampleリポジトリ](https://github.com/vercel/next.js/tree/canary/examples/blog-starter-typescript)では[tailwindcss](https://tailwindcss.com/)を使っていましたが、[materil-uiの<Box/>](https://material-ui.com/components/box/#box)[^1]が個人的に好きで、[パンくず](https://material-ui.com/api/breadcrumbs/#breadcrumbs-api)とか自分でつくろうとすると面倒だしとか、いろいろあってmateril-uiが採用されました。

[^1]: `<Box component="h1">`とか書くとh1タグとして使えますよすごくないですか。

てことで[参考に](https://zuma-lab.com/posts/next-material-ui-styled-components-settings)作らせていただきました。このサイトのこのページだけめっちゃ見た記憶ある。まあ、自分のサイトも現在は動いてるんで[コード](https://github.com/kajirikajiri/jamstack-tech-blog)参考になるかも知れません。

## d3.jsのtreemapを使って、サイトのカテゴリを実装する

ブログ作ってみたんですが、まあどこにでもあるサイトだなあと思ったんで、変わったものを[実装](/category)してみました。SEOとかいろいろ面倒なことに対処してたら時間かかりましたね。[最低でも8pxは開けてほしいとか](https://web.dev/accessible-tap-targets/)いろいろ言われたんですが、svgは上に要素を積んでいく感じで描画されるみたいで、リンクを設定した四角を描画した後に上に文字を描画してんですが、文字はリンクになってなくて。とはいえ文字をリンクにすると最低でも[最低でも8pxは開けてほしい](https://web.dev/accessible-tap-targets/)って怒られて大変でした。(clickイベント設定した。)下の要素に伝搬させればいいんじゃないかとか、上に透明なリンクを被せればいいんじゃないかとか考えましたが、svgの知識とか足りなくて時間かかりそうだったんで断念しました。

あとデータ形式[csv](https://www.d3-graph-gallery.com/graph/treemap_basic.html)と[json](https://www.d3-graph-gallery.com/graph/treemap_json.html)があって、最初csvの方でやったら、思ってたカテゴリ表示ができなくて[jsonのカスタム](https://www.d3-graph-gallery.com/graph/treemap_custom.html)で実装し直しました。[コード](https://raw.githubusercontent.com/kajirikajiri/jamstack-tech-blog/6ea56f558c975ef33da2db59367ea06c8f25f481/components/Category/index.tsx)がひどいことになりましたがものができてよかった

## AMP対応

[nextjsのamp対応](https://nextjs.org/docs/api-reference/next/amp)自体はかんたんに出来るんですが、ampってcssとかjsに縛りがあって、今までの実装が完全には使えなくて、中でもcssの実装が大変で、色々探したんですが、**[GoogleのCSS-FRAMEWORK](https://www.ampcssframework.com/)を試してみたんですがシンプルに使えなくて**、サイトの右上にGoogle AMP Test（これはあとから見たらかんちがいだった。amp対応しているかサイトをテストするやつ。）って書いてあって、googleでもまだテスト中なんだなと思って諦めました。
あと[mizch.dev](https://mizchi.dev/slides/develop-mizchi-dev)で

>(CSS が苦手なので助けて)

って書いてあるのが、普通のcssっていう意味じゃなくて縛りがあるうえでのcssのことだなって勝手に納得した。

適当に動かしてfullampの状態で試したときは確かに動作早かった。

## remarkjs

markdownをhtmlに変換してます。[remarkjs](https://github.com/remarkjs/remark)と[rehypejs](https://github.com/rehypejs/rehype)があって、[unifiedjs](https://github.com/unifiedjs/unified)をつかうことで共存させられるっぽいとこまで進んだところで闇だなと思って、remarkjsだけでつくり終わりました。package.jsonから引用すると

```
"remark-autolink-headings": "^6.0.1",
"remark-breaks": "^2.0.2",
"remark-footnotes": "^3.0.0",
"remark-html": "^13.0.1",
"remark-parse": "^9.0.0",
"remark-slug": "^6.0.0",
"remark-toc": "^7.2.0",
```

こんな感じでプラグインが豊富です。h1タグとかにリンク付けてくれるのとか、[スペース２個で改行](https://stackoverflow.com/a/35179094)じゃなくて、改行を改行として扱うやつとか、tocを生成してくれるやつとかあって便利です。ただ、終盤で疲れててドキュメント読解力が低下してて辛かった。

## lighthouse-ci

便利な時代になったなーって感じました。**github actionsでlighthouseを簡単に実行できます**。しかもgoogleさんが太っ腹なのでファイルを**googleさんのサーバーに無料でアップロード**させてくれます。

[設定ファイル1(ci.yml)](https://github.com/kajirikajiri/jamstack-tech-blog/blob/c518b34b7558be0e0afd0184e1b80f788784052c/.github/workflows/ci.yml)

```
name: CI
on: [push]
jobs:
  lhci:
    name: Lighthouse
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Use Node.js 14.x
        uses: actions/setup-node@v1
        with:
          node-version: 14.x
      - name: npm install, build
        run: |
          npm install
          npm run build
      - name: run Lighthouse CI
        run: |
          npm install -g @lhci/cli@0.7.x
          lhci autorun
        env:
          LHCI_GITHUB_APP_TOKEN: ${{ secrets.LHCI_GITHUB_APP_TOKEN }}
```

[設定ファイル2(lighthouserc.js)](https://github.com/kajirikajiri/jamstack-tech-blog/blob/c518b34b7558be0e0afd0184e1b80f788784052c/lighthouserc.js)

```
module.exports = {
  ci: {
    collect: {
      numberOfRuns: 1,
      staticDistDir: "./out",
    },
    upload: {
      target: "temporary-public-storage",
    },
  },
};
```

いつまで閲覧できるのか知りませんが、googleのサーバーにアップされてるlighthouseの結果は[こちら](https://storage.googleapis.com/lighthouse-infrastructure.appspot.com/reports/1620115043229-79181.report.html)です。

## sitemap生成

[next-sitemap](https://github.com/iamvishnusankar/next-sitemap#readme)でsitemapも生成できますよ。


```
"build": "next build && next export && yarn postbuild",
```

こんな感じの[buildコマンド](https://github.com/kajirikajiri/jamstack-tech-blog/blob/c518b34b7558be0e0afd0184e1b80f788784052c/package.json)になりました。デプロイするたびに生成できます。べんりですね。

[設定ファイル](https://github.com/kajirikajiri/jamstack-tech-blog/blob/c518b34b7558be0e0afd0184e1b80f788784052c/next-sitemap.js)はこんな

```
module.exports = {
  siteUrl: "https://kajiri.dev",
  generateRobotsTxt: true,
  sitemapSize: 7000,
  outDir: "./out",
};
```

## analyze

![next-analyze](assets/blog/jamstack-blog-2021/analyze.png)

yarn analyzeするだけでパッケージの使用割合も見れます。便利ですね

[npmjs](https://www.npmjs.com/package/@next/bundle-analyzer)の説明どおりにやったら簡単にどうにゅうできました。

## あとがき

いろんなパッケージが試せて満足しました。Jamstack試してみてはいかがでしょうか。Jamstackめっちゃはやいです（まだ記事が少ないからかも知れないという懸念はある。）。Jamstackしらべたら、静的ファイル配信でサーバー管理費用安いとか、セキュリティ高い、アナリティクス画面がよさそうだなーとかいいところあって決算も良さそうでCloudflareは買いかなーっていう気持ちです。

あと、lighthouseのスコアがなかなか高いです
![seo](assets/blog/jamstack-blog-2021/seo.png)

長期休暇が４日くらい消化されました。
