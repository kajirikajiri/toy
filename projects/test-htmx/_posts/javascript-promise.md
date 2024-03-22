---
title: "JavaScriptのpromiseの使い方"
excerpt: "みなさんこんにちは、かじりです。この記事はJavaScriptのpromiseについての説明をする記事です。例題多めで書いていきますので、実行しながら確認してみると理解が深まると思います。"
created_at: "2023-04-17 00:25:40"
updated_at: "2023-04-17 00:25:40"
tags: [javascript, usage, promise]
---

みなさんこんにちは、かじりです。この記事はJavaScriptのpromiseを解説しています。


## JavaScriptのPromiseを少し掘り下げる

まずはこれを実行してみると、okと表示されるはずです。

```
new Promise((resolve) => {
  resolve("ok");
}).then((value) => {
  console.log(value);
});
```

なぜokと表示されるのでしょうか。

まず、`new Promise((resolve) => { ... })`でPromiseオブジェクトを作成しています。
resolveは、Promiseが成功した場合に呼び出される関数です。
この例では、`resolve("ok")`でPromiseが成功したことを示し、成功時の値として文字列"ok"を渡しています。

次に、`then()`メソッドを使ってPromiseが成功したときに実行する関数を定義します。
`then()`メソッドに渡される関数は、Promiseが成功したときに呼び出され、成功時の値が引数として渡されます。
この例では、引数を`value`として定義して、コンソールに`value`の値を表示しています。

このコードを実行すると、Promiseオブジェクトが成功したため、`then()`メソッドに渡された関数が呼び出され、コンソールに"ok"という文字列が表示されます。

ここで気になるのは

1. `new Promise((resolve) => { resolve("ok") })`の`(resolve) => { resolve("ok") }`
2. `.then`

かなと思います。

1つ目の`(resolve) => { resolve("ok") }`は、アロー関数と呼ばれるJavaScriptの関数の形式の1つで、`resolve`という引数を受け取り、`resolve`関数を呼び出す関数を表します。  
この関数をPromiseオブジェクトのコンストラクターに渡して、新しいPromiseオブジェクトを作成しています。Promiseオブジェクトは、非同期処理が完了したときに、成功時の値または失敗時の理由を返すことができます。  
この場合、resolve関数に "ok"という文字列を渡しているため、Promiseが成功したという状態になり、"ok"という文字列がPromiseオブジェクトの成功時の値として返されます。  
アロー関数は、`=>`という構文で定義され、`resolve`という引数を取ります。引数が1つだけの場合は、括弧を省略することができます。そして、`{}`で囲まれたブロック内のコードが関数の本体になります。最後に、`resolve("ok")`を呼び出すことで、Promiseオブジェクトの成功を示しています。

2つ目の`.then()`は、Promiseオブジェクトのメソッドであり、Promiseオブジェクトの非同期処理が完了した後に呼び出されます。  
`.then()`は、1つまたは2つのコールバック関数を引数として受け取ります。第1引数はPromiseオブジェクトが成功した場合に実行される関数であり、Promiseが成功した際に渡される値を引数として受け取ります。第2引数は、Promiseオブジェクトが失敗した場合に実行される関数であり、Promiseが失敗した理由を引数として受け取ります。  
このように、`.then()`メソッドを使用することで、Promiseオブジェクトの非同期処理の完了後に実行する関数を指定することができます。例えば、先ほどのコードでは、`.then()`メソッドを使用して、Promiseオブジェクトの成功時に "ok" という文字列をコンソールに表示する関数を指定しています。  
`.then()`メソッドは、Promiseオブジェクトが非同期処理を完了するまで待機するため、非同期処理の完了前に呼び出されることはありません。また、`.then()`メソッド自体もPromiseオブジェクトを返すため、複数の`.then()`メソッドをチェーン状に呼び出すことができます。

これまでの説明を踏まえて、最初のコードを分解すると、以下のようになります。少しみづらくなっているかもしれませんが、結果は変わりません。

```
const promiseCallback = (resolve) => {
  resolve("ok");
}

const promise = new Promise(promiseCallback)

const thenCallback = (value) => {
  console.log(value);
}

promise.then(thenCallback);
```

ここまでのコードでは、`resove()`しか使っていませんが、`reject()`や`.catch()`を使ったり、`setTimeout()`で実行を遅らせてみると面白いと思います。

---

以下の記事も参考になるかもしれません

<a is="my-link" href="(/javascript-function)">JavaScriptのfunctionの使い方</a> 
