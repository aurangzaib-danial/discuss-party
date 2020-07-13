class AddDescriptionExcerptToTopics < ActiveRecord::Migration[6.0]
  def change
    add_column :topics, :description_excerpt, :text
  end
end
