class RemoveStepsInActionResult < ActiveRecord::Migration[8.0]
  def change
    remove_column :action_results, :steps, :text, null: false
  end
end
