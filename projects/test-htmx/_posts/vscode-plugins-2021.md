---
title: "vscodeのプラグイン 最近のいちおし２つ"
excerpt: "みなさんこんにちは、かじりです。今回はvscodeのプラグイン、最近のオススメを２つご紹介します。エディタ上からgithubのurlをコピペできるプラグインと日付の入力ができるプラグインになります。どちらも2021/5がつ頃に見つけて１ヶ月くらい常用しています。どうぞ使ってみてください"
created_at: "2021-05-20 23:25:34"
updated_at: "2021-05-20 23:25:34"
tags: [editor, vscode, plugins]
---

みなさんこんにちは、かじりです。よく[Obsidian](https://obsidian.md/)の記事を書きますが、今回はエディターの[vscode](https://code.visualstudio.com/)についてです。もうね、vscodeなしだと生きていけません（嘘です。[vim](https://www.vim.org/)も好きです）。qiitaでは[vscode 重い](https://qiita.com/kajirikajiri/items/fdca9b22548480fb8565) という記事を書きましたが悪口じゃないんです。本当にときどき重いんです。でもきほん快適でvimの入力も使えて。便利べんりという気持ちです。ちなみに[Insider](https://code.visualstudio.com/insiders/)派です。  
記事の内容ですが、簡単に言うと日付を入力できるプラグインとvscode上でファイル編集中にコマンドパレットからコマンドを実行するとgithubのmasterや今のブランチのurlをコピーできるというプラグインです。たまに当たりがあるんですよね。そういえば昔kajiriっていうプラグインをvscodeのmaeketplaceに公開したんですが、、、生きてましたｗ興味のある方はどうぞ[こちら](https://marketplace.visualstudio.com/items?itemName=kajiri.kajiri)です。7回もinstallされてる。うれしいですね。（いい拡張機能が２つしか見つかってないんです。がしかし、seo的に3000とか5000文字必要らしいんですね。ちょっと雑談多めでお送りしています）

## 日付を入力してくれるvscodeプラグイン
プラグインは[こちら](https://marketplace.visualstudio.com/items?itemName=jsynowiec.vscode-insertdatestring)になります。インストール後、使い方は簡単で `Insert Formatted DateTime` をコマンドパレットに入力してみてください。あとはEnterで日付が入力されます。ブログをMarkdownで記述するときとか、vscodeでメモをとる時に、日付、入力、メンドクサって自分は良くなるんです。こう、カレンダーを見て、日付をみて、、もうだめですね、入力する気力がなくなります。この拡張機能があれば、日付→コマンドパレット→insertdとかで一発ですよ。大変便利です。ありがとうございます。あ、ショートカットもあるんでさらに便利に使えそうですね。

拡張機能名は Insert Date String。リポジトリは[こちら](https://github.com/jsynowiec/vscode-insertdatestring)。Jakub Synowiecさんが作成されたようです。いいひげですね。

ひづけを即、入力できる

## githubのurlをコピーしてくれるvscodeプラグイン
プラグインは[こちら](https://marketplace.visualstudio.com/items?itemName=mattlott.copy-github-url)ですね。こちらのプラグインも簡単に使えます。インストール後、コマンドパレットに `Copy Github URL` を入力すると、masterやpermlinkが選択できるのでお好きなものを選択してください。masterにすればmasterからいけますし、permlinkを選べゔぁ、現在のブランチのコミットからいけたと思います。  
使う場面としては、あの行の内容を共有して確認したいなーって思った時に、コードをコピペして渡すのもありだと思います。しかし、コードのコピペだと、共有された人はコピペで受け取ったコードのみを頼るしかありません。ここで今回ご紹介したvscodeプラグインが役立つんです！githubのリポジトリのurlを渡せば、urlを開いて、対象のファイルの中身を確認できますし、他のファイルの確認も容易にできます。urlを受け取った人としては、ブランチのチェックアウトをする必要もありません。まあ本格的に調査するんだったら、ちゃんとエディタを開いた方が検索方法が豊富だったりするので良いと思います。あ、あといちいちブラウザを開かなくてもpermlinkが使えるっていうのがいいですね。

拡張機能名は Copy GitHub URL。リポジトリは[こちら](https://github.com/differentmatt/vscode-copy-github-url) Matt Lottさんが作成されたようです。ありがとうございます。便利です。

ブラウザを開かなくてもgithubのurlがコピペできる
master, permlink選択が容易
相手にブランチ切り替えを強要しない
コードをコピペで渡した場合よりも付近のコードの把握が容易

## まとめ

はい、ということでObsidianの、まちがえました、vscodeのプラグインを２つ紹介しました。どちらもさいきん常用していてオススメです。ぜひ使ってみてください。もうなんとか文字を増やそうっていう気持ちでしたが、細かく紹介できたんでよかったです。  
なんか最近algoliaが動いてないんですよね。。なんか設定ミスったかなーそのうち直さないと
