class RenameStatusToVisibilityInTopics < ActiveRecord::Migration[6.0]
  def change
    rename_column :topics, :status, :visibility
  end
end
