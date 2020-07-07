class RenameUserIdToCreatorIdInTopics < ActiveRecord::Migration[6.0]
  def change
    rename_column :topics, :user_id, :creator_id
  end
end
