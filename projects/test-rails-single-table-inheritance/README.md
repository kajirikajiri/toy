# README

https://www.martinfowler.com/eaaCatalog/singleTableInheritance.html
P of EAA: Single Table Inheritance

https://qiita.com/yebihara/items/9ecb838893ad99be0561
- Single Table Inheritance / 単一テーブル継承
- Class Table Inheritance / クラステーブル継承
- Concrete Class Inheritance / 具象クラス継承

https://api.rubyonrails.org/classes/ActiveRecord/Inheritance.html
inheritance_columnを定義すると、stiに使用するcolumnを変えられる。

https://qiita.com/ryonext/items/1a813639ab2a2a00058e
typeカラムを使うとエラーが出ることがある。
> ActiveRecord::SubclassNotFound: The single-table inheritance mechanism failed to locate the subclass: '戦艦'. This error is raised because the column 'type' is reserved for storing the class in case of inheritance. Please rename this column if you didn't intend it to be used for storing the inheritance class or overwrite Kantai.inheritance_column to use another column for that information.
from /Users/ryonext/.rbenv/versions/2.0.0-p247/lib/ruby/gems/2.0.0/gems/activerecord-3.2.13/lib/active_record/inheritance.rb:143:in `rescue in find_sti_class'

https://zenn.dev/shin_semiya/articles/7d5288753e9c28
> 継承されるクラスと同名のテーブルの中にstring型のtypeカラムを忘れるな

Martin, Fowler. Patterns of Enterprise Application Architecture (Addison-Wesley Signature Series (Fowler)) (pp.295-296). Pearson Education. Kindle 版. 
> Remember that the trio of inheritance patterns can coexist in a single hierarchy. So you might use Concrete Table Inheritance for one or two subclasses and Single Table Inheritance (278) for the rest. 
>
> 3つの継承パターンが1つの階層で共存できることを覚えておいてください。つまり、1つか2つのサブクラスには具象テーブル継承を使い、残りのサブクラスには単一テーブル継承（278）を使うということです。例 スケッチの実装を紹介します。

例で書かれている図では、単一テーブル継承を用いてPlayer MapperからFootballer Mapeer, Cricketer Mapper, Bowler Mapperを定義。具象テーブル継承を用いて、Abstract Player Mapperを継承したFootballer Mapper, Cricketer Mapper。Clicketer Mapperを継承したBowler Mapperを定義。している？ちょっとわからんな。