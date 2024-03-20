# Programmatically input data using e2e as a reference

みなさんこんにちは、かじりです。ブラウザ自動入力にはいつも困っています。文字を入力するところまでは割とできるんですが、クリックすると消えたりするんですよね。そういう自分の経験から困った時の対応方法をまとめました。よく方法を忘れる自分のための備忘録となっています。そもそもこの領域をやっている人が少ないと思いますが、検索で見つかってくれれば嬉しいな。自分が主に使っているのは、Chrome-Extensionの[executeScript](https://developer.chrome.com/docs/extensions/reference/tabs/#method-executeScript)によるJavaScriptの実行や、Flutterのwebview_flutterにある[evaluateJavascript](https://pub.dev/documentation/webview_flutter/latest/webview_flutter/WebViewController/evaluateJavascript.html)です。FlutterのevaluateJavaScriptの方が融通が効く印象で好きです。


## ブラウザ Programmatically input を検索するときに使えるワード

ここは簡単に終わらせますが、検索ワードとして使えるものは以下があると思います。

programmatically input
browser autopilot
trigger input event
automatically input

## 基本的な Programmatically input

特に変なことをしなければこれで自動入力可能です。あとは大体ボタンを押したりしても問題なく動きます。

```javascript
<input id="textfield" />

document.getElementById('textfield').value = 'foo'
```

## stackoverflowを探して見つかるブラウザ Programmatically input

SPA(single page application)など、ちょっと変わったサイトだと入力値が消えるので、eventを発生させる必要があります。[inputイベント(mdn)](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/input_event)や[changeイベント(mdn)](https://developer.mozilla.org/en-US/docs/Web/API/HTMLElement/change_event)を発生させます。

```javascript
<input id="textfield" />

const element = document.getElementById('textfield');
element.value = 'foo';
const event = new Event('input', { bubbles: true });
element.dispatchEvent(event);
```

```javascript
<input id="textfield" />

const element = document.getElementById('textfield');
element.value = 'foo';
const event = new Event('change', { bubbles: true });
element.dispatchEvent(event);
```

## Testcafeから考えるブラウザ Programmatically input

Testcafeはe2eテスト(ブラウザ自動操縦テスト)をするツールです。

なぜTestcafeを参考にするかというと、Testcafeはブラウザに直接JavaScriptを流し込みます。

こちら[slideshare](https://www.slideshare.net/hnisiji/stac2018-lt-125349647)からの引用です。

![image](assets/blog/thinking-about-programmatically-input-data-using-e2e-as-a-reference/slideshare.jpeg)

また、[公式サイトのアーキテクチャ説明](https://testcafe.io/documentation/402631/why-testcafe#an-architecture-like-no-other)にもそのような記述があります。一部を引用しますが、どうやらブラウザとサーバーの間にproxyサーバーをたててそこでJavaScriptを注入しているようです。

>An Architecture Like No Other
To simulate user activity, the automation engine behind TestCafe takes over browsers and the web pages they display.
Client-Server Architecture
TestCafe’s hybrid client-server architecture lets it execute both system-level and in-browser code.
TestCafe uses high-level system APIs to launch and manage browsers. This is necessary to control the test execution process.
TestCafe tests are Node.js scripts. They can launch services and applications, read and write system files, make use of your favorite libraries.
TestCafe uses client-side automation scripts to execute in-browser actions. This is how our testing library handles asynchronous events, simulates user activity, and executes user-defined JavaScript.
Early versions of TestCafe ran entirely in the browser. A hybrid architecture allowed us to improve test stability and extend the framework’s testing capabilities.
>>他に類を見ないアーキテクチャ
ユーザーの行動をシミュレートするために、TestCafeの自動化エンジンは、ブラウザとその表示するウェブページを引き継ぎます。
クライアント・サーバ・アーキテクチャ
TestCafe のハイブリッドなクライアント／サーバー・アーキテクチャにより、システムレベルとインブラウザの両方のコードを実行できます。
TestCafe は、ハイレベルなシステム API を使用して、ブラウザを起動・管理します。これは、テスト実行プロセスを制御するために必要です。
TestCafe のテストは、Node.js スクリプトです。サービスやアプリケーションを起動したり、システムファイルを読み書きしたり、お気に入りのライブラリを利用したりできます。
TestCafe は、クライアントサイド オートメーション スクリプトを使用して、ブラウザ内のアクションを実行します。このようにして、弊社のテストライブラリは、非同期イベントを処理し、ユーザーの活動をシミュレートし、ユーザー定義の JavaScript を実行します。
TestCafeの初期バージョンは、完全にブラウザ上で動作していました。ハイブリッド・アーキテクチャにより、テストの安定性を向上させ、フレームワークのテスト機能を拡張することができました。

>Page Proxying
You may notice that when you run TestCafe, the URL in the browser’s address bar does not match that of your website. This happens because TestCafe runs an under-the-hood reverse proxy.
The testcafe-hammerhead proxy intercepts browser requests and injects automation scripts into the requested pages. When the proxy receives data, it changes all the URLs on the resource so that they point to the proxy. This means that neither the client-side code nor other resources in use can tell that the page has been modified. To conceal automation scripts from the rest of the page code, TestCafe also intercepts some of the requests to the browser API.
The proxying mechanism ensures that the page appears to be hosted at the original URL even to the test code.
>>ページプロキシ
TestCafeを実行すると、ブラウザのアドレスバーに表示されるURLが、あなたのウェブサイトのものと一致しないことに気づくかもしれません。これは、TestCafeがアンダーザフッド・リバースプロキシを実行するために起こります。
testcafe-hammerheadプロキシは、ブラウザのリクエストを傍受し、リクエストされたページに自動化スクリプトを注入します。プロキシは、データを受け取ると、リソース上のすべてのURLを変更し、プロキシを指すようにします。これにより、クライアント側のコードも、使用中の他のリソースも、ページが変更されたことを知ることができません。自動化スクリプトを残りのページ コードから隠すために、TestCafe はブラウザ API へのリクエストの一部も傍受します。
このプロキシ機構により、テスト コードに対しても、オリジナルの URL でページがホストされているように見えます。

>Browser Sandboxing
At the end of each run, TestCafe deletes all browser cookies, empties the storage, and reloads the page, thereby preventing undesirable interference with subsequent tests. You don’t need to write boilerplate code to reset the app state and reverse the changes your tests make.
Tests that run in parallel operate in independent sandboxed environments. This helps prevent server-side collisions.
>>ブラウザのサンドボックス化
各実行の最後に、TestCafe はすべてのブラウザ Cookie を削除し、ストレージを空にしてページを再読み込みすることで、後続のテストへの望ましくない干渉を防ぎます。アプリの状態をリセットしたり、テストが行った変更を元に戻すために、定型的なコードを書く必要はありません。
並行して実行されるテストは、独立したサンドボックス環境で動作します。これにより、サーバーサイドでの衝突を防ぐことができます。

>Client-Side Scripts
TestCafe translates server-side test code into client-side JavaScript, and injects it into the browsers that it controls. This process enables the framework to perform common in-browser actions. Some testing scenarios, however, require the execution of custom client-side code. There are three ways to do it with TestCafe:
Client Scripts inject custom JavaScript files, such as temporary extra dependencies, into the page. Client Functions evaluate user-defined JavaScript expressions and pass their return value to the server side. They are useful when you want to examine the page or access its URL. The Selector function can launch user-defined client-side code to find a DOM element that cannot be otherwise identified.
>>クライアントサイド・スクリプト
TestCafeは、サーバーサイドのテストコードをクライアントサイドのJavaScriptに変換し、それを制御するブラウザに注入します。このプロセスにより、フレームワークはブラウザ内の一般的なアクションを実行することができます。しかし、いくつかのテストシナリオでは、カスタム クライアントサイド コードの実行が必要になります。TestCafe でそれを行うには、3 つの方法があります。
クライアントスクリプトは、一時的な余分な依存関係など、カスタムの JavaScript ファイルをページに注入します。クライアント関数は、ユーザー定義の JavaScript 式を評価し、その戻り値をサーバーサイドに渡します。これらは、ページを調査したり、その URL にアクセスしたい場合に便利です。セレクタ関数は、ユーザーが定義したクライアントサイドのコードを起動して、他の方法では特定できないDOM要素を見つけることができます。

>Note
The TestCafe documentation describes the limitations of user-defined client-side scripts.
>>注
TestCafe のドキュメントでは、ユーザー定義のクライアントサイドスクリプトの制限について説明されています。

また、実際にJavaScriptを注入しているのは[DevExpress/testcafe-hammerhead](https://github.com/DevExpress/testcafe-hammerhead)のようです。
実際の処理はコードを見てみた感じ[EventSimulator Class](https://github.com/DevExpress/testcafe-hammerhead/blob/e985143/src/client/sandbox/event/simulator.ts#L61)のようです。Testcafeの[type-test](https://github.com/DevExpress/testcafe/blob/master/src/client/automation/playback/type/type-text.js#L297)をみていくと、hammerheadを呼び出しています。

Testcafeは[chrome, IE, Edge, Firefox, safariなど複数ブラウザ対応しているので](https://testcafe.io/documentation/402828/guides/concepts/browsers#officially-supported-browsers)、[EventSimulator Class](https://github.com/DevExpress/testcafe-hammerhead/blob/e985143/src/client/sandbox/event/simulator.ts#L61)の自動入力箇所は参考になるはずです。
公式サイトのブラウザ対応表は[こちら](https://testcafe.io/documentation/402828/guides/concepts/browsers#officially-supported-browsers)にありますので確認お願いします。

## cypressから考えるブラウザ Programmatically input

上記Testcafeと同じように、cypressもブラウザに直接JavaScriptを流し込みます。

[slideshare](https://www.slideshare.net/hnisiji/stac2018-lt-125349647)から画像を再引用します。

![image](assets/blog/thinking-about-programmatically-input-data-using-e2e-as-a-reference/slideshare.jpeg)

cypressも公式サイトのArchitectureをみるとJavaScriptをInjectしていると思われる記述があります。Testcafeのようなproxy serverの記述はありませんが、Nodeのサーバープロセスを背後で実行しているようです。

>Architecture
Most testing tools (like Selenium) operate by running outside of the browser and executing remote commands across the network. Cypress is the exact opposite. Cypress is executed in the same run loop as your application.
Behind Cypress is a Node server process. Cypress and the Node process constantly communicate, synchronize, and perform tasks on behalf of each other. Having access to both parts (front and back) gives us the ability to respond to your application's events in real time, while at the same time work outside of the browser for tasks that require a higher privilege.
Cypress also operates at the network layer by reading and altering web traffic on the fly. This enables Cypress to not only modify everything coming in and out of the browser, but also to change code that may interfere with its ability to automate the browser.
Cypress ultimately controls the entire automation process from top to bottom, which puts it in the unique position of being able to understand everything happening in and outside of the browser. This means Cypress is capable of delivering more consistent results than any other testing tool.
Because Cypress is installed locally on your machine, it can additionally tap into the operating system for automation tasks. This makes performing tasks such as taking screenshots, recording videos, general file system operations and network operations possible.
>>アーキテクチャー
ほとんどのテストツール（Seleniumなど）は、ブラウザの外で動作し、ネットワークを介してリモートコマンドを実行することで動作します。Cypressはその正反対です。Cypressは、あなたのアプリケーションと同じランループで実行されます。
Cypressの背後には、Nodeのサーバープロセスがあります。CypressとNodeプロセスは、常にコミュニケーションをとり、同期をとり、お互いのためにタスクを実行しています。フロントとバックの両方にアクセスできることで、アプリケーションのイベントにリアルタイムに対応することができると同時に、より高い権限を必要とするタスクをブラウザの外で実行することができます。
また、Cypressは、Webトラフィックを読み取り、その場で変更することで、ネットワーク層でも動作します。これによりサイプレスは、ブラウザに出入りするすべてのものを変更できるだけでなく、ブラウザの自動化に支障をきたすコードを変更することもできます。
サイプレスは、最終的に自動化プロセス全体を上から下までコントロールしているため、ブラウザの内外で起こっていることをすべて理解できるというユニークな立場にあります。つまり、Cypressは、他のどのテストツールよりも安定した結果を出すことができるのです。
Cypressはユーザーのマシンにローカルにインストールされるため、自動化タスクのためにOSを利用することもできます。これにより、スクリーンショットの撮影、ビデオの録画、一般的なファイルシステムの操作、ネットワークの操作などのタスクを実行することができます。

cypressは[type.jsのtype](https://github.com/cypress-io/cypress/blob/7192a78/packages/driver/src/cy/commands/actions/type.js#L16)をみていくと、[elements.tsのdescriptor](https://github.com/kajirikajiri/cypress/blob/7192a78/packages/driver/src/dom/elements.ts#L71)があるのですが、ここら辺のgetOwnPropertyDescriptorをうまく使って値をセットしています。
実際の自動入力処理に落とし込むと以下のようになります。

```javascript
<input id="textfield" />

const element = document.getElementById('textfield');
const valueSetter = Object.getOwnPropertyDescriptor(element, 'value').set;
const prototype = Object.getPrototypeOf(element);
const prototypeValueSetter = Object.getOwnPropertyDescriptor(prototype, 'value').set;
if (valueSetter && valueSetter !== prototypeValueSetter) {
    prototypeValueSetter.call(element, 'new value');
} else {
    valueSetter.call(element, 'new value');
}
element.dispatchEvent(new Event('input', { bubbles: true }));
```

Object.getOwnPropertyDescriptorは、JavaScriptの経験が多い自分でも初めてみましたが、引数に与えたObjectが持っている関数とかを呼び出すようです。
細かくみていくと

```javascript
const valueSetter = Object.getOwnPropertyDescriptor(element, 'value').set;
```

element.valueのsetterを呼び出しているようなのですが、そもそも普通に使っていると最初の方の例で示した通り以下の方法で値をセットできます。

```javascript
<input id="textfield" />

document.getElementById('textfield').value = 'foo'
```

なので、setterがあることを知りませんでしたし、setterを呼び出す方法があることも知りませんでした。
詳しく知りたい方は[mdn](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/getOwnPropertyDescriptor)をご覧ください。
また、上記自動入力に関しては、stackoverflowの[この記事](https://stackoverflow.com/a/53797269)や[こちらの記事](https://stackoverflow.com/a/62111884)も参考になるかもしれません。

## あとがき

JavaScriptは本当に奥が深いです。普通じゃない問題でも大体は対処できるのですが、getOwnPropertyDescriptorとか初めて見たし、まだまだ奥は深いな〜って思います。
もっとJavaScriptが知りたいんだ！って方は[レキシカルスコープ](https://wemo.tech/904#index_id11)とか、[You-Dont-Know-JS](https://github.com/getify/You-Dont-Know-JS/blob/2nd-ed/get-started/README.md)をおすすめします。
最近はマーケ勉強してます!