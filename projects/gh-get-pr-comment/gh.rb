require 'open3'
require 'dotenv/load'
require 'json'
require 'singleton'
  
class Gh
  def initialize
    @owner = ENV.fetch('OWNER') # リポジトリオーナー
    @repo = ENV.fetch('REPO') # リポジトリ名
    @target_user = ENV.fetch('TARGET_USER') # コメントを取得したいユーザーのID
  end
  
  def show_pr_comments
    # commentsを整形するlambda。notionへ貼り付けて使うことを想定している。
    format_comment = ->(comment) do
      <<~REVIEW
        [link](#{comment.dig('url')})

        #{comment.dig('body')}

        . . . . . . . . . . . . . . . . .
      REVIEW
    end
  
    puts fetch_pr_review_comments.map(&format_comment).join
  end
  
  def show_rate_limit
    # rate_limitを取得するghコマンド
    gh_rate_limit = "gh api rate_limit"
  
    # used/limitで最も利用しているものからorderして、リセットまでの時間を表示
    # NOTE: 一応、dig('resources')と並列にもう一個keyが残っているが、使ってない
    rate_limit_logs =
      JSON.parse(execute_command(gh_rate_limit)).
        dig('resources').sort_by { |k, v| v['used'].to_f / v['limit'].to_f }.
        select { |v| puts v; v[1]['used'] > 0 }.
        reverse.
        map { |v| "#{v[0]}: #{Time.at(v[1]['reset']).strftime('%Y-%m-%d %H:%M:%S')}, 使用状況: #{v[1]['used']}/#{v[1]['limit']}" }
    if rate_limit_logs.empty?
      puts "APIを全く利用していません。"
    else
      puts rate_limit_logs.join("\n")
    end
  end
  
  private

  def execute_command(command)
    stdout, stderr, status = Open3.capture3(command)
    raise "Error: #{stderr}" unless status.success?
    
    stdout
  end
  
  # 特定の人がレビューしたPRの番号を作成の降順(?)で取得する
  # WARN: pageInfoにhasNextPageを入れるとレスポンスが来ないので、endCursorがnilになるまで繰り返す
  def fetch_pr_review_comments
    comments = []
    end_cursor = ''
    100.times do |i|
      gh_pr_comments = <<~GH
        gh api graphql \
          --paginate \
          -f query='
            query {
              search(#{end_cursor.empty? ? '' : "after: \"#{end_cursor}\", "}type: ISSUE, query: "is:pr reviewed-by:#{@target_user} repo:#{@owner}/#{@repo} sort:created", first: 40) {
                pageInfo {
                  endCursor
                }
                nodes {
                  ... on PullRequest {
                    reviewThreads(first: 100) {
                      nodes {
                        comments(first: 100) {
                          nodes {
                            url
                            body
                            author {
                              login
                            }
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          '
      GH
      res = JSON.parse(execute_command(gh_pr_comments)).dig('data', 'search')
      end_cursor = res.dig('pageInfo', 'endCursor')
      comments +=
        res.dig('nodes').
          flat_map { |node| node.dig('reviewThreads', 'nodes') }.
          flat_map { |node| node.dig('comments', 'nodes') }.
          flatten.
          select { |comment| comment.dig('author', 'login') == @target_user }
      puts "コメント取得中...#{i + 1}回目: #{comments.size}件"
      
      break if end_cursor.nil?
    end
    comments
  end
end

# コマンドライン引数を受け取る
# ARGV[0]がrate_limitの場合はAPI制限を取得
# ARGV[0]がprの場合はPRのコメントを取得

if ARGV[0] == 'rate_limit'
  Gh.new.show_rate_limit
elsif ARGV[0] == 'pr'
  Gh.new.show_pr_comments
else
  raise "引数が不正です。rate_limitかprを指定してください。"
end
