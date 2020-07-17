class AddReportsCountToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :reports_count, :bigint, null: false, default: 0
  end
end
