---
title: "typescriptでobjectのtypeguardにinstanceofを使う"
excerpt: "みなさんこんにちは、かじりです。今回はtypescriptのobjectのtypeguardについてです。"
coverImage: "/assets/blog/typescript-type-guard-object/cover.png"
date: "2022-01-22 19:21:07"
author:
  name: かじり
  picture: "/me.jpg"
ogImage:
  url: "/ogp/1200x630.png"
category:
  first: sidework
  second: search
tags: [typescript, typeguard, instanceof]
---

# typescriptでobjectのtypeguardにinstanceofを使う

みなさんこんにちは、かじりです。今回はobjectのtypeguardについてです。

---

## instanceofを使おう

概要です。以前はobjectの型判定をするtypeというkeyを持たせていたが、classにすることによりinstanceofで条件分岐できるようになった。

以下はコード例です

before

```
type Obj = {
    type: 'a'
} | {
    type: 'b'
}
const obj: Obj = {type: 'a'}

if (obj.type === 'a') {
    ...
} else if (obj.type === 'b') {
    ...
} else {
    ...
}
```

after

```
class A {}

class B {}

const obj = new A()

if (obj instanceof A) {
    ...
} else if (obj instanceof B) {
    ...
} else {
    ...
}

```

実験用のcodesandboxです

https://codesandbox.io/s/workflow-type-guard-umxjj?file=/src/App.tsx

---

調査過程

自分がやりたいことはtypeguardという。typeofまたはinstanceofを使用する。

https://stackoverflow.com/a/35546468

自分が使おうと思ってよく断念するisによる型の絞り込みはユーザー定義型ガードという。

https://blog.uhy.ooo/entry/2021-04-09/typescript-is-any-as/

instanceofがよさそうだなー

でもhooksで使いたいんだよなー
