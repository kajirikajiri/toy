---
title: "Obsidianの使い方"
excerpt: "みなさんこんにちは、かじりです。Obsidianの使い方は最初すごく悩みました。Obsidianは細かいところに手が届く感じで使いやすいのですが、どのように使っていけばいいのかわからなかったです。今回は自分のObsidian使い方を経験を踏まえてまとめてみました。"
coverImage: "/assets/blog/obsidian-usage-2021/cover.svg"
date: "2021-05-20 22:13:24"
author:
  name: かじり
  picture: "/me.jpg"
ogImage:
  url: "/ogp/1200x630.png"
category:
  first: editor
  second: obsidian
tags: [obsidian]
---

# Obsidianの使い方

みなさんこんにちは、かじりです。今回は１年半くらい使用したObsidianについてです。小分けに書いたので、もくじ(Table of Contents)から探してもらえるとわかりやすいと思います。
また、[Obsidian](https://obsidian.md/)は開発が活発でこの記事はすぐに古くなると思うのでObsidianのバージョンに気をつけてください。執筆時のバージョン[^1]はv0.11.13です

[^1]: Obsidianのバージョンは設定の上から５番目Abountの一番上にあります。


## コマンドパレットを開く

そのままですが、コマンドパレットを開きます。[vscodeのコマンドパレット](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette)とおなじような機能です。

`ctrl/cmd p`

[Obsidian公式のhelp](https://help.obsidian.md/How+to/Keyboard+shortcuts)に書いてます。

検索機能があるので、ショートカット忘れたりしてもこれでわりとなんとかなります。

また、Core pluginsなのでオフにすることもできます。

設定の上から6番目Core pluginsの上から9番目のCommand paletteで切り替えできます

## 表示モードと編集モードを切り替える

これもそのままですが、markdownの表示モードと編集モードを切り替えます。トグルで切り替わります。

`ctrl/cmd e`

これも[Obsidian公式のhelp](https://help.obsidian.md/How+to/Keyboard+shortcuts)に書いてます。

なれないうちはわすれやすいですが、便利な機能です。

## もどる/すすむ

直前に操作していたノートやタブに戻ります。Obsidianって別のノートを開くと、同じタブでひらくので、直前に開いていたノートに戻れなくて最初の頃困りました。これを使えば、進んだり戻ったりして直前のノートが開けるので便利です。

`ctrl/cmd + Alt + Left arrow`
`ctrl/cmd + Alt + Right arrow`

これも[Obsidian公式のhelp](https://help.obsidian.md/How+to/Keyboard+shortcuts)に書いてます。

[タブ切り替え](/obsidian-usage-2021#%E3%82%BF%E3%83%96%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88)と混同しやすいので注意です

## タブ切り替え

別タブで開いているノートを開きます

`ctrl/cmd + tab`
`ctrl/cmd + shift + tab`

これは[もどるすすむ](/obsidian-usage-2021#%E3%82%82%E3%81%A9%E3%82%8B%E3%81%99%E3%81%99%E3%82%80)と混同しやすいので注意です

## 現在の行を切り替える

現在の行をリスト表示やtodoに切り替える事ができます。

[編集モード](/obsidian-usage-2021#%E8%A1%A8%E7%A4%BA%E3%83%A2%E3%83%BC%E3%83%89%E3%81%A8%E7%B7%A8%E9%9B%86%E3%83%A2%E3%83%BC%E3%83%89%E3%82%92%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%82%8B)で`ctrl/cmd+enter`です

## プレビューを表示する

表示モードだとマウスカーソルを内部リンクにホバーさせると表示されます。編集モードだと、ctrlを押す必要があります。
ノートを開かなくても中身が確認できて非常に便利です。最初の頃、previewが表示されなくて、cssがこわれてるのか？obsidianが壊れてるのか？と思いましたが、設定が足りてないだけでした。ただ、プレビューで検索すると、markdownの表示モードがプレビューらしくてそれとごっちゃに検索されるので見つかりづらいです。
cssだとpopoverを編集すると見た目を変えたりできます。

設定の上から6番目Core pluginsの上から7番目のPage previewで切り替えできます

## 保存方法

[Obsidian](https://obsidian.md/)はローカルで管理できるっていう点が素晴らしいですが、保存されているのがローカルだけだとやはり不安ですよね？ということでgithubに保存しましょう。自分はzsh使ってるんですが、ターミナルにobsidianって入力すると、addからpushまで一括で実行するコマンドを登録してます。

```
function obsidian() {
  local current_dir
  current_dir="$(pwd)"
  cd /mnt/c/Obsidian
  git add .
  git commit -m "$(date +%Y%m%d%H%M%S)"
  git push
  cd $current_dir
}
```

[自動保存するプラグイン](https://github.com/denolehov/obsidian-git)設定してみたんですがね、動かなかったですよね。まあなんか読み間違えたんだと思うんで、うまくやれば動くかも？

## 削除設定

デフォルトだと削除するとシステムのゴミ箱に入っちゃうんで別のフォルダに移動するようにしましょう
「設定の上から２番目Files&Links > Deleted filesのセレクトボックスでMove to Obsidian trash (.trash folder) 」にしましょう

## 新規作成したファイルの保存先

デフォルトだと新規作成したノートがrootに保存されるのでrootがどんどん膨れていきます。個人的（個人的にです）に嫌なので、これを別のフォルダにしましょう。
「設定の上から２番目Files&Links > Folder to create new notes in  にフォルダを設定」すれば全部そのディレクトリに入ります。

画像も保存先を変えましょう。Obsidianは画像を直接貼り付ける事ができますが、これもrootに保存されます。
「設定の上から２番目Files&Links > Attachment folder path にフォルダを設定」すればokです。

## ノートを横スクロール

[lyt-kit](https://publish.obsidian.md/lyt-kit/)を触ってみた人ならわかるかと思うんですが、複数のノートを開いたときに、ノートが横スクロールするのかっこいいですよね。これはSliding PanesというCommunity pluginsです。

設定の上から８番目Community Pluginsの右側にBrowseっていうボタンがあると思うのでクリックして、検索ボックスで検索しましょう。

Sliding Panes の[github](https://github.com/deathau/sliding-panes-obsidian)はこちらです

## リンクを使う

[[をObsidianで入力すると入力補完されるのでまずは入力してみるといいです。
詳細は下記です

**\[\[ノート名\]\]**
これでノートへのリンクが作成できます。

**\[\[ノート名|表記名\]\]**
ひとつ上と同じ効果ですが、[表示モード](/obsidian-usage-2021#%E8%A1%A8%E7%A4%BA%E3%83%A2%E3%83%BC%E3%83%89%E3%81%A8%E7%B7%A8%E9%9B%86%E3%83%A2%E3%83%BC%E3%83%89%E3%82%92%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88%E3%82%8B)で表示される名前が変わります

**\[\[ノート名#見出し\]\]**
ノートの中のh1タグとかの見出し行を指定することができます。
ノートの中で`[[#`と入力するとノート内の見出し行が入力補完されて便利ですよ

**\[\[ノート名^見出し\]\]**
ノートの中の好きな行を指定できます。
ノートの中で`[[^`を入力するとノート内の行が入力補完されます。こちらも便利です。

実際の使い方として、
1. `[[`を入力して入力補完からノート名を指定
2. `[[ノート名]]`が完成
3. `[[ノート名#]]`のようにノート名の後ろに#や^を入力
4. 入力補完から行を選択する
て感じで使います。使ってみると便利です

## 参照

こちらの記事も参考になるかも知れません

<a is="my-link" href="(/obsidian-moc-usage-2021)">Obsidian MOCの使い方 第１話</a> 
<a is="my-link" href="(/obsidian-moc-usage-part-2-2021)">Obsidian MOCの使い方 第２話</a> 
<a is="my-link" href="(/obsidian-vscode-extension)">Obsidian vscode拡張機能について公式サイトで調べた</a> 
<a is="my-link" href="(/obsidian-ios-android-mobile-app)">Obsidianのiosとandroidのモバイルアプリが公開された</a> 
