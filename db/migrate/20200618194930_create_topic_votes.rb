class CreateTopicVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :topic_votes do |t|
      t.integer :vote
      t.bigint :topic_id, null: false, foreign_key: true
      t.bigint :user_id, null: false, foreign_key: true

      t.timestamps
    end
    add_index :topic_votes, [:topic_id, :user_id], unique: true
  end
end
