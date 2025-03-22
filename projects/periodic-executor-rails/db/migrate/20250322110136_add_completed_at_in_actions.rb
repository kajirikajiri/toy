class AddCompletedAtInActions < ActiveRecord::Migration[8.0]
  def change
    add_column :actions, :completed_at, :datetime, comment: '完了日時'
    add_column :actions, :status, :integer, default: 0, null: false, comment: 'ステータス'
    add_column :actions, :logs, :text, comment: 'ログ'
  end
end
