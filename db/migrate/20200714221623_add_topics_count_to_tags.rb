class AddTopicsCountToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :topics_count, :bigint, default: 0
    change_column_null :tags, :topics_count, false
  end
end
