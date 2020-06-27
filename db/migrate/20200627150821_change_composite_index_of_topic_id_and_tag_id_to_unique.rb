class ChangeCompositeIndexOfTopicIdAndTagIdToUnique < ActiveRecord::Migration[6.0]
  def change
    remove_index :topic_tags, [:topic_id, :tag_id]
    add_index :topic_tags, [:topic_id, :tag_id], unique: true
  end
end
