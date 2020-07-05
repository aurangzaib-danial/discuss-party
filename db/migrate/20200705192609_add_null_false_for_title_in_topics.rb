class AddNullFalseForTitleInTopics < ActiveRecord::Migration[6.0]
  def change
    change_column_null :topics, :title, false
  end
end
