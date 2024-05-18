引用している文字やコードはiPhoneで撮影してGPT-4で修正、整形している

4~5ページ
>§ 1.2 パターンのためのパターン
>これらの問いに答えるために、GoFは彼らの本の冒頭でいくつかの一般的な原則、メタ設計パターンについて述べています。私なりにそれらのアイデアを要約すると、次の4つのポイントになります。
>・変わるものを変わらないものから分離する
>・インターフェイスに対してプログラムし、実装に対して行わない
>・継承より集約
>・委譲，委譲，委譲
>これらに、GoF本では言及されていませんが、プログラムを書く際に私がとても気をつかっている1
>つのアイデアを加えたいと思います。
>・必要になるまで作るな
>次の節ではこれらの原則について、それぞれがソフトウェアの構築にとってどのように重要なのかを順に見ていきます。


>変わるものを変わらないものから分離する

変わらなければいいけど、変わらないものなどない。
ではどうやって変わるものを分離するのか？

>インターフェイスに対してプログラムし、実装に対して行わない

例えばこのコードはCarクラスと結合している
```ruby
car = Car.new
car.drive(200)
```

AirPlaneクラスが増えた時など、毎回のように条件分岐を増やすことになる
```ruby
if is_car
    car = Car.new
    car.drive(200)
else
    plane = AirPlane.new
    plane.fly(200)
end
```

このように１つの共通のインターフェイスを使うのが良い
```ruby
behicle = get_behicle
behicle.travel(200)
```

> 継承より集約

継承だと望ましくない結合が生まれることがある。集約を使おう。

継承だとこんな感じ。engineがない乗り物を実装する時にBehicleクラスに大改造が必要になる
```ruby
class Behicle
    def start_engine
        ...
    end
    def stop_engine
        ...
    end
end

class Car < Behicle
    def drive
        start_engine
        ...
        stop_engine
    end
end
```

集約。他の乗り物を増やしたくなって、Engineが使えるならCarクラスのようにinitializeすれば良い。

エンジンが不要ならエンジンを使わなければ良い。
```ruby
class Engine
    def start
        ...
    end
    def stop
        ...
    end
end

class Car
    def initialize
        @engine = Engine.new
    end
    def drive
        @engine.start
        @engine.stop
    end
end
```

また、76ページによると、基底クラスになるBehicleは使わないらしい。乗り物は同じようにdriveをする。。。いや、これはTemplateパターンの場合の話かもしれない。Planeクラスならflyだろうし。まあ、でもBehicleがやっていたstart_engine, stop_engineはそれぞれの乗り物のEngineが担当するようになっている。


---

55~86ページ Template Methodパターン~Strategy

Template Methodパターンでは同じような初期化を行い、あとは共通のprintによって出力している。

例えば、HTMLReportとPlainTextReportを作り、initializeが同じ引数を受け取り、同じoutputメソッドで出力する。

これで、いろんな出力のパターンに対応できる。

Abstractクラスで定義すべきものを指定し、継承により縛る。

Strategyの場合は、委譲する。

最終的にはProcをformatterとして、取り込むことでいろんな出力ができるようになる。

途中段階では、Formatterクラスを切り替えることで実現している。

Formatterクラスの場合は複数の引数に対応できる点が良い。Procはできない。

最初の例

これは単純なReport

```ruby
class Report
  def initialize
    @title = '月次報告'
    @text = ['順調', '最高の調子']
  end

  def output_report
    puts '<html>'
    puts '  <head>'
    puts "    <title>#{@title}</title>"
    puts '  </head>'
    puts '  <body>'
    @text.each do |line|
      puts "    <p>#{line}</p>"
    end
    puts '  </body>'
    puts '</html>'
  end
end
```

次の例。単純にフォーマットの追加をifで切り抜ける例

私も２個くらいならこれでいくかもしれない。単純だし。楽だし。まあわかるでしょ。

例では、この時点でリファクタ始める

```ruby
class Report
  def initialize
    @title = "月次報告!"
    @text = ['順調', '最高の調子!']
  end

  def output(format)
    raise "Unknown format: #{format}" unless [:plain, :html].include?(format)

    if format == :plain
      puts "*** #{@title} ***"
      @text.each { |line| puts line }
    elsif format == :html
      puts '<html>'
      puts '  <head>'
      puts "    <title>#{@title}</title>"
      puts '  </head>'
      puts '  <body>'
      @text.each { |line| puts "    <p>#{line}</p>" }
      puts '  </body>'
      puts '</html>'
    end
  end
end
```

あれ、abstractクラス使ってると思ったらそんなことなかった。まあいいや

それぞれのclassで実装すべきものはraiseでエラーを出力。

メインのロジックはReportクラスに書いてしまう。

フックメソッドが実装されている。そのタイミングでやりたい処理があれば実装する。output_*系のメソッドが全てraiseしているが、今回の場合はデフォルトでは何もしない実装でも良さそうと61~62ページにあった。PlainTextReportでは実際、ほとんどのメソッドをオーバーライドして何もしないようにしているが、これはReportが何もしない実装になっていればPlainTextReportはオーバーライド不要。

```ruby
class Report
  def initialize
    @title = '月次報告'
    @text = ['順調', '最高の調子！']
  end

  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each { |line| output_line(line) }
  end

  def output_start
    raise 'Called abstract method: output_start'
  end

  def output_head
    raise 'Called abstract method: output_head'
  end

  def output_body_start
    raise 'Called abstract method: output_body_start'
  end

  def output_line(line)
    raise 'Called abstract method: output_line'
  end

  def output_body_end
    raise 'Called abstract method: output_body_end'
  end

  def output_end
    raise 'Called abstract method: output_end'
  end
end

class HTMLReport < Report
  def output_start
    puts '<html>'
  end

  def output_head
    puts '<head>'
    puts "<title>#{@title}</title>"
    puts '</head>'
  end

  def output_body_start
    puts '<body>'
  end

  def output_line(line)
    puts "<p>#{line}</p>"
  end

  def output_body_end
    puts '</body>'
  end

  def output_end
    puts '</html>'
  end
end

class PlainTextReport < Report
  def output_start; end

  def output_head
    puts "**** #{@title} ****"
  end

  def output_body_start; end

  def output_line(line)
    puts line
  end

  def output_body_end; end

  def output_end; end
end
```

委譲の例、Strategyではこうなっている

変わる部分だけが別のクラスに別れていていい感じに見える。

使いたいFormatterをReportに渡してやれば良い。

attr_*は今回の場合使わなくても良さそうに見える。次のリファクタで使うようになるようだ。

```ruby
class Formatter
  def output_report(title, text)
    raise 'Abstract method called'
  end
end

class HTMLFormatter < Formatter
  def output_report(title, text)
    puts '<html>'
    puts ' <head>'
    puts "   <title>#{title}</title>"
    puts ' </head>'
    puts ' <body>'
    text.each do |line|
      puts "   <p>#{line}</p>"
    end
    puts ' </body>'
    puts '</html>'
  end end

class PlainTextFormatter < Formatter
  def output_report(title, text)
    puts "******#{title}******"
    text.each do |line|
      puts line
    end
  end
end

class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(formatter)
    @title = "月次報告"
    @text = ["順調", "最高の調子"]
    @formatter = formatter
  end

  def output_report
    @formatter.output_report(@title, @text)
  end
end

formatter = HTMLFormatter.new
report = Report.new(formatter)
report.output_report

plain_formatter = PlainTextFormatter.new
report.formatter = plain_formatter
report.output_report
```

次に、ReportからFormatterへの値を引数ではなく、自身の参照として渡すようにする。

Reportクラスはattr_readerとattr_accessorにより、title, textの読み込み、formatterへの読み書きができるので、selfを引数で渡せばそれらのの値が読み書きできる。

しかし、過剰な権限を与えているような気もする。これだと、Reportクラスのインスタンスからtitle, textが見えるし、formatterクラスを読み書きができてしまう。GPT-4に聞いてみた感じ、将来を見越した戦略だと言われた。Strategyを外部から変更したり、titleやtextの読み取りが可能。しかし、それはYAGNI違反ではないのか？と聞くとそれはその通りだと言われた。しかしStrategyパターンは戦略を取り替えることで色々な戦略を使えるようにするもののようだから、Strategyパターンとしてあっているということだろう。

途中を省略するが最終的にはこうなる。

lambdaで定義されたFormatterを定数として取り込み、ReportのインスタンスをFormatterに渡す。ずいぶんシンプルになった。

```ruby
class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = "月次報告"
    @text = ["順調、最高の調子！"]
    @formatter = formatter
  end

  def output_report
    @formatter.call(self)
  end
end

HTML_FORMATTER = lambda do |context|
  puts '<html>'
  puts '<head>'
  puts "<title>#{context.title}</title>"
  puts '</head>'
  puts '<body>'
  context.text.each do |line|
    puts "<p>#{line}</p>"
  end
  puts '</body>'
  puts '</html>'
end
```

