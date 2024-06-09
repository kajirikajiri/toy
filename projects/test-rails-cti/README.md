# README

https://qiita.com/yebihara/items/9ecb838893ad99be0561
- Class Table Inheritance / クラステーブル継承

ポリモーフィック関連を使った実装
https://blog.smartbank.co.jp/entry/2023/09/07/093000

eager loadやprelaodの例
https://tech.stmn.co.jp/entry/2020/11/30/145159
https://zenn.dev/d0ne1s/articles/fdf4832d478da6
smartbankの例でpreloadをやってて気になったので調べた。テストを書いてクエリを見てみた。確かに毎回sqlを発行しなくていいのでpreload良さそうだった。

left outer join
https://sql55.com/t-sql/t-sql-join-3.php
smartbankの例でeager loadがあって、調べたらleft outer joinしているようなので調べた。条件が一致したレコードがあれば、左側にjoinするようだ。あんまり意識しないから覚えてない。

ポリモーフィック関連を使った実装
https://zenn.dev/aion/articles/e91b5629ac7811

ポリモーフィック関連を使わない実装。Delegated typesが出る前に書かれた記事
https://qiita.com/akichim21/items/39f05adbddea39fc7075

Delegated typesのrailsドキュメント
https://api.rubyonrails.org/classes/ActiveRecord/DelegatedType.html

Railsガイドのdelegateの説明
https://railsguides.jp/active_support_core_extensions.html#%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E3%81%AE%E5%A7%94%E8%AD%B2
メソッドを委譲できる。例でいえば、Userに紐づくProfileクラスからnameメソッドをuserのnameのように呼び出せる。例にあるように、classメソッドをインスタンスから呼び出すようなこともできるらしい。delegate :table_name, to: :class

https://qiita.com/yebihara/items/9ecb838893ad99be0561#concrete-class-inheritance--%E5%85%B7%E8%B1%A1%E3%82%AF%E3%83%A9%E3%82%B9%E7%B6%99%E6%89%BF
> サブクラスが増えるとテーブルも増える
> 論理的なレコード全体を取得するのにジョインが必要
> Railsでは、サブクラス固有属性を取得するためにコードを書く必要がある

短所としてこれらが挙げられていた。STIに比べるとテーブルが増える。確かに。STIならレコードの取得が楽そうだ。
長所に挙げられているように、外部キー制約やNULLの発生の抑制に良さそう。

Martin, Fowler. Patterns of Enterprise Application Architecture (Addison-Wesley Signature Series (Fowler)) (pp.286-287). Pearson Education. Kindle 版. 
> When to Use It
 Class Table Inheritance, Single Table Inheritance (278) and Concrete Table Inheritance (293) are the three alternatives to consider for inheritance mapping. The strengths of Class Table Inheritance are • All columns are relevant for every row so tables are easier to understand and don’t waste space. • The relationship between the domain model and the database is very straightforward. The weaknesses of Class Table Inheritance are • You need to touch multiple tables to load an object, which means a join or multiple queries and sewing in memory. • Any refactoring of fields up or down the hierarchy causes database changes. • The supertype tables may become a bottleneck because they have to be accessed frequently. • The high normalization may make it hard to understand for ad hoc queries. You don’t have to choose just one inheritance mapping pattern for one class hierarchy. You can use Class Table Inheritance for the classes at the top of the hierarchy and a bunch of Concrete Table Inheritance (293) for those lower down.
>
> どのような場合に使用するか
 クラス・テーブル継承、単一テーブル継承(278)、具象テーブル継承(293)が、継承マッピングの3つの選択肢である。クラステーブル継承の長所は - すべてのカラムがすべての行に関連するため、テーブルが理解しやすく、スペースを無駄にしない。- ドメインモデルとデータベースの関係が非常にわかりやすい。クラス・テーブル継承の弱点は - オブジェクトをロードするために複数のテーブルに触れる必要がある。- オブジェクトをロードするために複数のテーブルに触れる必要がある。- スーパータイプ・テーブルは頻繁にアクセスしなければならないため、ボトルネックになる可能性がある。- 正規性が高いため、アドホックなクエリでは理解しにくいかもしれない。1つのクラス階層に対して1つの継承マッピング・パターンだけを選択する必要はありません。階層の一番上のクラスにはクラス・テーブル継承を使い、その下のクラスには具象テーブル継承（293）を使うことができます。

アドホックなクエリというあたりがよくわからなかった。GPT-4と話した感じでは普段の開発や即席でデータを取得しようとしてSQLを書くのがやりづらいという感じだった。
アドホックとは？と思いGPT-4に聞いた → アドホック（ad hoc）はラテン語の「そのために」を語源とし、特定の目的のために即席で行うことを指します。
