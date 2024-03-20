# Obsidian vscode拡張機能について公式サイトで調べた

みなさんこんにちは、かじりです。今回はvscodeで使えるobsidanの拡張機能を、Obsidanの公式サイトのフォーラムやObsidianの公式サイトのgithubリポジトリから調べてみたので共有したいと思います。


## VSCodeの拡張機能ストアでObsidianを探す

[VSCodeのMarketPlace](https://marketplace.visualstudio.com/search?term=obsidian&target=VSCode&category=All%20categories&sortBy=Relevance)でObsidianを検索してみましたが、カラーテーマが15個、keybindが2個、BlockChainの拡張機能が1個、その他が1個見つかるのみでした。もう少しうまく検索できそうな気もしますが、自分は見つけることができませんでした。調べた時の画像が以下です。  

![search-obsidian-in-vscode-market-place](assets/blog/obsidian-vscode-extension/vscode-market-place.png)

## Obsidianの公式サイトのフォーラムのVSCode拡張機能の話し合い

Obsidian公式サイトのフォーラムで「Obsidian as a VSCode extension(VSCode拡張としてのObsidian)」という記事での[Obsidianの開発者の方の発言](https://forum.obsidian.md/t/obsidian-as-a-vscode-extension/2818/11)からの引用です。

> Like others said, VSCode can do some heavy lifting for us, but it have many limitations. Some of them are listed here: https://github.com/svsool/vscode-memo/issues/1#issuecomment-655004112 (I’m sure you’ve already read that).  We’re not considering making Obsidian into a VSCode, especially with its current scope. Further discussion is still welcome, but I’m archiving this so we’re not implementing it.
>> 他の人が言ったように、VSCodeは私たちのためにいくつかの重い仕事をすることができますが、多くの制限があります。そのうちのいくつかをここに列挙します。https://github.com/svsool/vscode-memo/issues/1#issuecomment-655004112 すでにお読みになったと思いますが）。 我々はObsidianをVSCodeにすることは考えていません、特に現在の範囲では。さらなる議論は歓迎しますが、実装しないためにこれをアーカイブしています

また、引用文章内部のリンク先からも引用します。

> Image preview on hover for images with UNC paths does not work with Windows due to VSCode CORS settings, but local paths should work just fine
>> Windowsでは、VSCodeのCORS設定により、UNCパスの画像のホバー時の画像プレビューが動作しないが、ローカルパスであれば問題なく動作する。

>  Better search. Built-in VSCode search is not nearly as good as it could be in case of the knowledge base
>>  より良い検索。内蔵されているVSCodeの検索機能は、ナレッジベースの場合ほど優れているとは言えません。

上記を抜粋すると、Obsidianの開発者の方がVSCodeの拡張機能としてのObsidianという記事でObsidianをVSCodeにすることは考えていないという発言をしています。また、githubのissueでは具体的に問題となる箇所があげられたようです。しかし、現在の範囲ではというような発言もあるので、もしかすれば可能性はあるかもしれません。

## Obsidian公式サイトのフォーラムで見つけたVSCodeの拡張機能(Memo)

Obsidian公式サイトのフォーラムで「Obsidian as a VSCode extension(VSCode拡張としてのObsidian)」という記事で[Memo](https://marketplace.visualstudio.com/items?itemName=svsool.markdown-memo)というVSCode拡張機能が紹介されています。機能としては[[]]形式でのlinkに対応していて、ファイル名の変更でノート内のリンク名の変更にも対応、ファイル名にホバーでノートをpopup表示できるなど、Obsidianに近い使い方ができそうです！  
また、上で紹介したgithubのissueが[Memo](https://marketplace.visualstudio.com/items?itemName=svsool.markdown-memo)の開発リポジトリのissueでした。  

[Memoのリポジトリ](https://github.com/svsool/vscode-memo)の引用です、
>Inspired by Obsidian.md and RoamResearch.
>>Obsidian.mdとRoamResearchを参考にしました。

どうやら、MemoはObsidianと[RoamResearch](https://roamresearch.com/)を参考に作られているようです  

Obsidianを探しているときにRoamResearchも見つけたのですが、Obsidianが無料で使うことができたので、Obsidianを試してみたらいい感じで使えたのでそのままObsidianを使い続けています。

## Obsidian公式サイトのフォーラムで見つけたVSCodeの拡張機能(Foam)

こちらもObsidian公式サイトのフォーラムで見つけました。[Foam](https://foambubble.github.io/foam/)といいます。拡張機能は[こちら](https://marketplace.visualstudio.com/items?itemName=foam.foam-vscode)です。

[Foamの公式サイト](https://foambubble.github.io/foam/)から引用します。
>Foam is a personal knowledge management and sharing system inspired by Roam Research, built on Visual Studio Code and GitHub.
>You can use Foam for organising your research, keeping re-discoverable notes, writing long-form content and, optionally, publishing it to the web.
>Foam is free, open source, and extremely extensible to suit your personal workflow. You own the information you create with Foam, and you’re free to share it, and collaborate on it with anyone you want.
>>Foam は、Roam Research にインスパイアされ、Visual Studio Code と GitHub 上に構築された、個人向けの知識管理・共有システムです。
>>Foam は、研究の整理、再発見可能なメモの保存、長文コンテンツの作成、そしてオプションでウェブへの公開に使用できます。
>>Foamは無料でオープンソースであり、個人のワークフローに合わせて非常に柔軟に拡張することができます。Foamで作成した情報はあなたのものであり、誰とでも自由に共有し、共同作業を行うことができます。

FoamはVSCodeで無料で使うことができるようです。また、obsidianのようなグラフも表示されるようなのでいいかもしれません。

## 参照

こちらの記事も参考になるかも知れません

<a is="my-link" href="(/obsidian-usage-2021)">Obsidianの使い方</a> 
<a is="my-link" href="(/obsidian-moc-usage-2021)">Obsidian MOCの使い方 第１話</a> 
<a is="my-link" href="(/obsidian-moc-usage-part-2-2021)">Obsidian MOCの使い方 第２話</a> 
<a is="my-link" href="(/obsidian-ios-android-mobile-app)">Obsidianのiosとandroidのモバイルアプリが公開された</a> 

## あとがき

今回はVSCodeのObsidian拡張機能についてでした。ちょっと調べた感じ、[このgithubアカウント](https://github.com/ericaxu)の方が、Obsidianをメインで開発しているように見えるのですが、類似点として、[アカウントの画像](https://forum.obsidian.md/u/Silver/summary)が同じである、[Obsidian公式のTwitterのリンク](https://twitter.com/obsdmd)がgithubに貼り付けてある、[Obsidianのgithub](https://github.com/obsidianmd/obsidian-releases/graphs/contributors)を見るとコミット数が一番多いということしか見つけられず、確定ではないけど多分この人だろうなっていう感じでした。  
