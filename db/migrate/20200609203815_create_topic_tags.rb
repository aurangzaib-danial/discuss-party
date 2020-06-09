class CreateTopicTags < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_tags do |t|
      t.bigint :topic_id, null: false, foreign_key: true
      t.bigint :tag_id, null: false, foreign_key: true
      t.index [:topic_id, :tag_id]
      t.timestamps
    end
  end
end
