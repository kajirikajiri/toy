class CreateSlackMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :slack_messages, id: :string do |t|
      t.integer :status, null: false, default: 0, comment: '投稿ステータス'
      t.string :channel, null: false, comment: '投稿されるSlackチャンネルのid'
      t.string :ts, comment: 'Slack APIで取得/投稿したts'
      t.string :text, comment: 'Slack APIで取得/投稿したテキスト'
      t.text :response, comment: 'Slack APIで取得/投稿したresponse'
      t.string :thread_ts, comment: 'Slack APIで取得/投稿したthread_ts'
      t.timestamps
    end
  end
end
