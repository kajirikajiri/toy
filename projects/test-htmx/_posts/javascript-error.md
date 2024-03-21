---
title: "JavaScriptのErrorの使い方"
excerpt: "みなさんこんにちは、かじりです。この記事はJavaScriptのErrorについて書いています"
coverImage: "/assets/blog/javascript-error/cover.png"
date: "2023-04-22 21:43:08"
author:
  name: かじり
  picture: "/me.jpg"
ogImage:
  url: "/ogp/1200x630.png"
category:
  first: javascript
  second: usage
tags: [javascript, usage, error]
---

# JavaScriptのErrorの使い方

みなさんこんにちは、かじりです。この記事はJavaScriptのErrorについて書きます。


## Errorの第二引数causeについて

まずは使い方から。エラーの第二引数にcauseを与えると、error.causeとして使うことができます。

```
const error = Error("sample", {cause: Error("sample 2")})
console.log(error.cause)
```

このように第二引数のcauseは、オプションの引数であり、エラーの原因に関する情報を提供するために使用されます。  
また、causeの値はどのようなものでもよいです。catch文で束縛された変数がErrorであると断定できないのと同じように、キャッチしたエラーの原因が Errorであると断定してはいけないです。  

cause以外、例えばaをあたえても、aはundfinedになります。


```
const error = Error("sample", {a: "a"})
console.log(error.a)
```

https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Error/cause

causeにわたしたエラーのstack traceが一緒に表示されることはなかったです。例えば以下の例文ではsampleというエラーが表示されます。sample 2は表示されません。

```
const error = Error("sample", {cause: Error("sample 2")})
console.log(error)
```

---

以下の記事も参考になるかもしれません

<a is="my-link" href="(/javascript-promise)">JavaScriptのpromiseの使い方</a> 
