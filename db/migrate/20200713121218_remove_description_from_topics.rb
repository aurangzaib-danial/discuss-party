class RemoveDescriptionFromTopics < ActiveRecord::Migration[6.0]
  def change
    remove_column :topics, :description, :text
  end
end
