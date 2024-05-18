class Report
  attr_reader :title, :text
  attr_accessor :formatter

  def initialize(&formatter)
    @title = "月次報告"
    @text = ["順調", "最高の調子！"]
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

PLAIN_TEXT_FORMATTER = lambda do |context|
  puts "******#{context.title}******"
  context.text.each do |line|
    puts line
  end
end

report = Report.new(&HTML_FORMATTER)
puts report.title
pp report.text
puts "HTMLフォーマット"
report.output_report

puts "プレーンテキストフォーマット"
report.formatter = PLAIN_TEXT_FORMATTER
report.output_report
