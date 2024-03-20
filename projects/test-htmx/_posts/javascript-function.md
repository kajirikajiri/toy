# JavaScriptのfunctionの使い方

みなさんこんにちは、かじりです。この記事はJavaScriptのpromise, async, awaitを説明するために、functionの説明からやっていこうと思い、記載しています。
まずは、パソコンで開きましょう。スマホだとコードを実行できませんし、コードが読みづらいと思います。スマホだったら、一回ブックマークして、パソコンで開き直しましょう。
あとは、上が簡単で下にいくほど難しいので上から呼んでみてください。


## まずはhello worldをJavaScriptのfunctionで実行する

まず、コードを実行できるように準備します。ブラウザなら[devtool](https://www.google.com/search?q=devtool+chrome)を使ったり、[playground](https://www.google.com/search?q=javascript+playground)を使ってください。

あとはコード例がたくさんあるので、実行してどのように動いているか確認しながら読んでみてください。

また、注意点として、ブラウザ実行する場合、前の履歴が残っていると失敗することがあるので、**失敗したらブラウザをリロード**してみてください。その後に実行するとうまくいくことがあります。

あと、先に間違ったコードを記載しておくことがあるので、読みながら先にそれはおかしい！と気づけると良いです

### hello worldをJavaScriptのfunctionで実行する

まずはhello worldからやっていきます。

```javascript
function helloWorld () {
  console.log('hello world')
}
```

これを実行すると、hello worldと出力されません。
正しくは下記です。

```javascript
function helloWorld () {
  console.log('hello world')
}
helloWorld()
```

このように**functionは定義して実行する**必要があります。
以下に定義と実行を分けて記載します。

### JavaScriptのfunctionを定義する

```javascript
function helloWorld () {
  console.log('hello world')
}
```

### JavaScriptのfunctionを実行する

```javascript
helloWorld()
```

## JavaScriptのfunctionを色々な方法で使ってみる

### JavaScriptのfunctionを定義しないで実行してみる

ではfunctionを定義しないで実行してみましょう。

```javascript
undefinedFunction()
```

これを実行すると`Uncaught ReferenceError: undefinedFunction is not defined`と表示されると思います

では、エラーを発生させずに実行するにはどうすれば良いでしょう？

```javascript
function undefinedFunction () {}

undefinedFunction()
```

これでエラーなく実行できるはずです。

### JavaScriptのfunctionで引数を使ってみる

```javascript
function argumentFunction (x) {
  console.log(x)
}

argumentFunction(1)
```

こうすることで画面に1と表示されると思います。ではxをyに変更したらどうなるでしょう。

```javascript
function argumentFunction (y) {
  console.log(y)
}

argumentFunction(1)
```

1が表示されたと思います。では、100を表示するにはどうすれば良いでしょう。

```javascript
function argumentFunction (y) {
  console.log(y)
}

argumentFunction(100)
```

これで100が表示されたと思います。

### JavaScriptのfunctionで複数の引数を使ってみる

複数の引数を使ってみましょう

```javascript
function multipleArgumentFunction (x, y) {
  console.log(x, y)
}

multipleArgumentFunction(1, 2)
```

こうすることで画面に1, 2と表示されると思います。では1, 2, 3と表示するにはどうすれば良いでしょう？

```javascript
function multipleArgumentFunction (x, y, z) {
  console.log(x, y, z)
}

multipleArgumentFunction(1, 2, 3)
```

1, 2, 3が表示されたと思います。他の方法として

```javascript
function multipleArgumentFunction (x, y) {
  console.log(x, y, 3)
}

multipleArgumentFunction(1, 2)
```

これでも1, 2, 3が表示できたと思います。

### JavaScriptのfunctioneで数値を返す

```javascript
function returnNumberFunction () {
  return 1
}

returnNumberFunction()
```

はい、これで`returnNumberFunction`というfunctionで数値を返すことができました。確認してみましょう。

```javascript
function returnNumberFunction () {
  return 1
}

const result = returnNumberFunction()
console.log(result)
```

これで1と表示されたはずです。

### JavaScriptのconsole.logでfunctionの結果を表示してみる

これはさっきと同じです。

```javascript
function returnNumberFunction () {
  return 1
}

const result = returnNumberFunction()
console.log(result)
```

これを少し変更してみましょう。

```javascript
const result = function returnNumberFunction () {
  return 1
}()
console.log(result)
```

これでも同じ結果が表示されたと思います。
さらにまとめてみましょう。(みづらいのであまり実用的ではないです)

```javascript
console.log(function returnNumberFunction () {
  return 1
}())
```

これでも同じ結果になると思います。
ではさらにまとめてみましょう。

```javascript
console.log(function () { return 1 }())
```

これも同じ結果だと思います。ずいぶん小さくなりましたね。
もっとまとめてみましょう。

```javascript
console.log((() => 1)())
```

これも同じ結果を返します。このようにいろんな書き方ができます。

上で出てきた特殊な書き方を解説していきます。

```javascript
function returnNumberFunction () {
  return 1
}() // ← ??
```

最後の行の()をみることがあまりないです。これはfunctionをそのまま実行しています。例えば以下はどうでしょう。

```javascript
function returnNumberFunction () {
  return 1
}

returnNumberFunction()
```

いつも通りのfunctionに見えます。`returnNumberFunction`を**呼び出すときは()を後ろにつける**と思います。

ですが、functionを定義して、後から呼び出すのではなく、functionを定義した時に呼び出すことができます。なので

```javascript
function returnNumberFunction () {
  return 1
}()
```

このような書き方が可能になります。

また、()は結構なんでもできます。以下に色々書いたので、こんな書き方もできるんだなくらいに思ってください。

```javascript
(console.log('hello'));
(function(){console.log('hello')}());
function hello () {
  return function () {
    return function () {
      console.log('hello')
    }
  }
}
hello()()()
const hello2 = () => () => () => console.log('hello')
hello2()()();
(()=> console.log('123'))()
;(function(){console.log('123')})()
```

### JavaScriptのfunctioneeを変数に代入してみる

functionを変数に代入してみましょう。

**functionの結果を変数に代入するのではありません**。

**functionを変数に代入**します。

```javascript
function sum (x, y) {
  return x + y
}

const result = sum
```

これで、**functionを変数に代入**できました。
では実行してみましょう。

```javascript
function sum (x, y) {
  return x + y
}

const result = sum

console.log(result(1, 2))
console.log(sum(1, 2))
```

このように、resultもsumも両方使うことができます。

### callback functionを使ってみる

callback functionを使ってみます。

```javascript
function callback (func) {
  func()
}

function greet () {
  console.log('hello')
}

callback(greet)
```

helloと表示されたかと思います。これがcallback functionです。JavaScriptを4年経験しましたが大変読みづらいです。

callbackを取り除いて同じ結果を出力しようとするとこうなります。

```javascript
console.log('hello')
```

じゃあそう書いてくれ。そう思います。でも、**callbackは使う**んです。もう使っているかもしれません。例えばsetTimeoutです。

### setTimeoutを例にcallback functionを考える

```javascript
setTimeout(function () { console.log('hello') }, 1000)

setTimeout(function () {
  console.log('hello') }
, 1000)
```

上記２つはどちらも同じsetTimeoutです。改行の有無だけが違います。

setTimeoutという関数の１つ目の引数に`function(){console.log('hello')}`

２つ目の引数に1000を渡しています。

これはsetTimeout functionに1秒後に`function(){console.log('hello')}`を実行してねという意味です。なので、functionにfunctionを渡しています。もう一つmapというfunctionを例えに使います。

### map functionを例にcallback functionを考える

```javascript
// function
[1,2,3].map(function (x) {console.log(x)})

// arrow function
[1,2,3].map((x) => {console.log(x)})
```

上記はどちらか見たことがあるかもしれません。これもmapというfunctionの引数に`function (x) {console.log(x)}`を渡しています。

### 今までの例を参考にcallback functionを使ってみる

例題は以上にしてcallback functionを定義して実行します

```javascript
function callback (func) { // 1
  func()                   // 2
}                          // 3
function greet () {        // 4
  console.log('hello')     // 5 
}                          // 6
callback(greet)            // 7
```

これの処理順としては
1. 1行目でcallbackが定義される
2. 4行目でgreetが定義される
3. 7行目でcallbackが呼び出され、greetが引数で渡される
4. 2行目でcallbackの引数に渡されたgreetが実行される
5. 5行目でconsole.logが実行される

という流れです。

---

以下の記事も参考になるかもしれません

<a is="my-link" href="(/javascript-promise)">JavaScriptのpromiseの使い方</a> 