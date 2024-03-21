---
title: "Material-UIに学ぶFigmaの使い方"
excerpt: "みなさんこんにちは、かじりです。最近はFigmaを学習しています。oouiを実現したいという目標があります。「使いやすさを重視した総合的なデザインを心がければ、美しさは後からついてくることが多いのです。」というFigmaの教えに習ってまずは使いやすいデザインを身につけるためです。しかし最低限の見た目を再現方法があまり分かりませんでした。なので、自分がfrontendの開発によく使用しているMaterial-UIのコンポーネントがFigmaでどのように表現されているのか？というところを勉強します。"
coverImage: "/assets/blog/learn-from-material-ui-how-to-use-figma/cover.png"
date: "2021-09-11 00:49:07"
author:
  name: かじり
  picture: "/me.jpg"
ogImage:
  url: "/ogp/1200x630.png"
category:
  first: design
  second: figma
tags: [design, figma, material-ui]
---

# Material-UIに学ぶFigmaの使い方

みなさんこんにちは、かじりです。

Figmaのtutorialにはこのようにあります。

[「デザインには多くの場合、視覚的な要素や存在があります。デザインを視覚的に具現化するには、見て楽しい、体験して楽しいものであることが理想です。使いやすさを重視した総合的なデザインを心がければ、美しさは後からついてくることが多いのです。」](https://www.figma.com/resources/learn-design/what-is-graphic-design/#:~:text=Designs%20often%20have%20a%20visual%20element%20or%20existence%2C%20and%20the%20visual%20embodiment%20of%20a%20design%20is%2C%20ideally%2C%20pleasant%20to%20look%20at%20and%20experience.%20Often%2C%20if%20you%20set%20out%20to%20design%20your%20product%20in%20a%20way%20that%20is%20holistically%20focused%20on%20ease%20of%20use%2C%20aesthetics%20will%20follow)

上記を自分なりに解釈すると以下のようになります。

見て楽しい、体験して楽しいものを作る。そのためには、使いやすさを重視したデザインを心がける。美しさは後からついてくる。

使いやすいデザインを調べたところ、oouiというものが見つかったので勉強中です。

oouiをなんとなく理解したので、形にしようと思いFigmaを使い始めましたが、使い方がよく分かりません。

frameはどう組み合わせるのか？border-bottomがない？などいろいろありました。

何かを参考にしたいと考えた時、自分がfrontendを実装しているときによく使っているMaterial-UIを思い出したので、Figmaを検索したところ、[Material-UIのコンポーネント集](https://www.figma.com/community/file/912837788133317724)を見つけました。

今回はこれを元に勉強したことをまとめます。


## Figmaでborder-bottomを使いたい

自分の調査不足の可能性がありますが、Figmaにはborder-bottomを設定する箇所がないようです。

Material-UIのFigmaを見ると、border-bottomを設定する2つの方法を見つけました。Material-UIのTableとTextFieldでborder-bottomが設定されていました。

### 1. Material-UIのTableの場合

Material-UIのTableを参考にします。

こちらのTableの画像。border-bottomが設定されています。ちょっとTableっぽくないですが、TableのCellになります。

![](assets/blog/learn-from-material-ui-how-to-use-figma/cell.svg)

border-bottomを設定するのに必要なのは２点です。

- Effects
- Fill

<div is="hint-box">EffectsとFillはFigma右側メニューの「Design」に設定項目があります。Design, Prototype, Inspectの「Design」です。</div>

#### Effectsの設定

Effectsはこのように設定されていました。

![](assets/blog/learn-from-material-ui-how-to-use-figma/cell2.png)

<div is="hint-box">border-topがやりたいときは、Yの値を1にしましょう。</div>

#### Fillの設定

Fillはこちらになっていました。

Material-UIのTableでは特殊なFillの指定をしているようでFillが表示されていないですが、以下の画像の箇所の右側にあるハイフンを押すと設定が削除されFillが表示されます。

![](assets/blog/learn-from-material-ui-how-to-use-figma/cell3.png)

その後にFillを設定しましょう。

![](assets/blog/learn-from-material-ui-how-to-use-figma/cell4.png)

#### ハマったところ
最初はEffectsのみ設定したのですが、border-bottomは表示されませんでした。そこでFillを設定したところ、border-bottomが表示されました。

ちなみに、EffectsをDrop shadowにしてもborderを表示することが可能です。この場合もFillを設定しましょう。fillを設定せずにDrop shadowを設定した場合、内側の要素にもDrop shadowが適応されているのが見えてしまい、影が表示されます。。以下参考

![](assets/blog/learn-from-material-ui-how-to-use-figma/cell5.svg)

### 2. Material-UIのTextFieldの場合

Material-UIのTextFieldになります。border-bottomが設定されているようです。

![](assets/blog/learn-from-material-ui-how-to-use-figma/textField.svg)

そしてComponentをみてみると、「activeというLine」と「defaultというLine」が「UnderlineというFrame」でまとめられています。

![](assets/blog/learn-from-material-ui-how-to-use-figma/textField2.png)

ということで以上のように、Lineを使ってborder-bottomを再現することもできるようです。

<div is="hint-box">Material-UIのTextFieldの場合にshadowを使用しない理由が分かっていません。推測では太さが2px以上の場合、shadowでは再現できなかった？もしくはdefaultのLineとactiveのLineで色を分けて表示する必要があった？</div>

## Material-UIのTextFieldをみてみる

Material-UIのFigmaでは、どのようにFrameを組み合わせてComponentを作成しているのか？Material-UIのTextFieldを調べてみました。

### 繰り返し使用するComponentをまとめている

#### 繰り返し使用するComponentの設定

まず、繰り返し使用するComponenetは以下のようにまとめられています。

![](assets/blog/learn-from-material-ui-how-to-use-figma/component.svg)

構成は以下のようになっています。

![](assets/blog/learn-from-material-ui-how-to-use-figma/component2.png)

右側のメニューのDesignはこのようになっています。

![](assets/blog/learn-from-material-ui-how-to-use-figma/component4.png)

まず、InputElementsのFrameがAutoLayoutの縦並びになっていることがわかります。内側に24のpadding、それぞれの要素の間には24のSpaceが設定されています。InputElementsのFrame内に新しくFrameなどを追加すると、自動で縦並びに追加されていくため、使い勝手が良かったです。参考にします。

例として、Input textをコピー&ペーストした場合、以下のようにちょうどいい場所に新しくInput Textが追加されます。

![](assets/blog/learn-from-material-ui-how-to-use-figma/component3.svg)

#### Variantsの設定

繰り返し使用するComponentのIconがあります。これらはInputAdornmentというFrameになっています。

![](assets/blog/learn-from-material-ui-how-to-use-figma/component5.svg)

frontendの実装よりの話になりますが、[Material-UIのTextFieldにはStartAdornmentとEndAdornmentが設定できます](https://material-ui.com/api/input/#main-content)。違いとしてはInputの先頭、末尾のどちらにIconを置くか設定できることです。

もしMaterial-UIのTextFieldを一度も見ずに自分が同じ状況でデザインをする必要が出たら、先頭と末尾は別のProps(StartAdornmentとEndAdornment)をReact.jsで設定するので、FigmaのVariantsでまとめない方がいいのでは？と思っていたかもしれません。

このようにVariantsでまとめるということが知れて良かったです。

また、FigmaのVariantsは1クリックで使用するFrameを切り替えることができるので非常に便利です。

Material-UIのTextFieldのFigmaは共通で使用されるFrameを繰り返し使えるように、Componentsにまとめており、再利用ができてすごくメンテナンス性が高そうです。このようにやっていくようにします。

## Material-UIのButtonを見てみる

Material-UIのButtonはこのようになっています。

画像が少し小さいのですが、左、中央、右で同じTextが置かれているように見えます。

![](assets/blog/learn-from-material-ui-how-to-use-figma/button.svg)

実際のボタンは以下のようになっています。

左がContained Button、中央がOutlined Button、右がText Buttonになっています。

![](assets/blog/learn-from-material-ui-how-to-use-figma/button2.svg)

初めの画像で左、中央、右に同じTextが置かれていたのは、左がContained Button用のText、中央がOutlined Button用のText、右がText Button用のTextになっていたためです。

![](assets/blog/learn-from-material-ui-how-to-use-figma/button3.svg)

しかし、よく考えるとContainedとOutlined、TextをそれぞれComponentにして、Variantsで切り替えることもできるのではないか？と思いました。

考えられることとしては、FigmaのComponentは若干使いづらいという点が挙げられるかと思います。

使いづらいのはComponentを解除する時です。FrameをComponentにするときはショートカットキーですぐにできます。しかし、Componentを解除するというショートカットキーがありません。なのでComponentを解除するには、ComponentからInstanceを作成し、InstanceにDetach InstanceすることでComponentを解除できます。この一手間が個人的には非常に面倒でした。それが理由として挙げられるかもしれません。

他の理由としては、Text Buttonのサイズが違うことが挙げられるかもしれません。Text Buttonだけは他のButtonより21px小さいです。なので、Componentを分ける理由になるかもしれません。

また、もしOutlined, Contained、TextのButtonをまとめた場合にVariantの設定がわかりにくいというのも理由かもしれません。

![](assets/blog/learn-from-material-ui-how-to-use-figma/button4.png)

このように、Variant: Text, Size: Largeというようになっていますが、もし一つにまとめた場合、Variant: ContainedTextやSize: ContainedLargeになってしまうと思います。このようなわかりづらいVariantやTextを避けるためにOutlined, Contained, TextでVariantを分けたという可能性があります。

Material-UIのAlertも確認してみたのですが、わかりやすいVariantsになるように配慮されているように見えました。

## オススメ!Figmaのショートカットキー

| key     | short cut         |
|-----------|---------------------|
|  ctrl + shift + ? | shortcut key help         |
| shift + a     | auto-layout         |
| cmd + click | direct child select |
| n | Zoom to next frame |
| shift + n | Zoom to previrous frame |
|cmd + g| group selection |
|cmd + option + g| frame selection |
|option + L| toggle directory |
|cmd + .| hide menu |
|enter|select inner component|
|shift + enter| select outer component |
|tab| select next component |
|shift + i| insert component |
|shift + 2|zoom frame|
|shift + 0|zoom frame|
|+|zoom in|
|-|zoom out|

---

いろいろと勉強になりました！

自分がfrontendの実装に使用していたMaterial-UIコンポーネントは全て存在しているように見えました。

Figmaの使い方の参考におすすめです。

[Material-UIのコンポーネント集](https://www.figma.com/community/file/912837788133317724)

こちらの記事も参考になるかも知れません

<a is="my-link" href="(/design-learn-with-figma-1)">エンジニアがfigmaでデザインを学習する</a> 
