require 'open3'
require 'dotenv/load'
require 'json'

class Gh
  def initialize
    # .envからTARGET_REPOを取得
    # リポジトリオーナー
    @owner = ENV.fetch('OWNER')
    # リポジトリ名
    @repo = ENV.fetch('REPO')
    # コメントを取得したいユーザーのID
    @target_user = ENV.fetch('TARGET_USER')
  end

  def fetch_pr_comments
    prs = fetch_prs
    text = extract_pr_comments_text(prs)
    puts text
  end
  
  private
  
  def execute_command(command)
    stdout, stderr, status = Open3.capture3(command)
    raise "Error: #{stderr}" unless status.success?
    
    stdout
  end
  
  # 100件以上のデータを取得したい場合は、gh api graphqlに--paginateをつけて、startCursorを使って取得する。endCursorとbeforeはつかえない。
  # https://cli.github.com/manual/gh_api
  def fetch_prs
    prs = []
    start_cursor = ""
    try = 0
    5.times do
      try += 1
      command = <<~COMMAND
        gh api graphql \
          --paginate \
          -F owner=#{@owner} \
          -F repo=#{@repo} \
          -F after=#{start_cursor} \
          -f query='
            query(#{start_cursor.empty? ? '' : '$after: String'}, $owner: String!, $repo: String!) {
              repository(owner: $owner, name: $repo) {
                pullRequests(#{start_cursor.empty? ? 'first: 40' : 'first: 40, after: $after'},states: [OPEN, CLOSED]) {
                  pageInfo {
                    startCursor
                    hasNextPage
                  }
                  nodes {
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
            }'
      COMMAND
      tmp = JSON.parse(execute_command(command)).dig('data', 'repository', 'pullRequests')
      nodes = tmp.dig('nodes')
      has_next_page = tmp.dig('pageInfo', 'hasNextPage')
      raise 'No nodes' if nodes.empty?

      prs += nodes
      start_cursor = tmp.dig('pageInfo', 'startCursor')
      return prs unless has_next_page
      try = 0
      puts "PRを取得中... #{prs.length}件"
    rescue RuntimeError => e
      if try < 3 && e.message == 'No nodes'
        sleep 1
        retry
      end
      puts prs.length
      raise 'Max retry'
    end
    prs
  end
  
  def extract_pr_comments_text(prs)
    text = ""
    prs.each do |pr|
      comments = pr.dig('reviewThreads', 'nodes').flat_map { |review_thread| review_thread.dig('comments', 'nodes') }
        .select { |comment| comment.dig('author', 'login') == @target_user }
      comments.each_with_index do |comment, index|
        text << <<~REVIEW
          #{comment.dig('url')}
          #{comment.dig('body')}
          #{comments.size - 1 == index ? '================================' : ''}
        REVIEW
      end
    end
    text
  end
end

gh = Gh.new
gh.fetch_pr_comments