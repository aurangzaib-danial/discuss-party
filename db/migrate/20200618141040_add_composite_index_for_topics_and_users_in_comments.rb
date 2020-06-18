class AddCompositeIndexForTopicsAndUsersInComments < ActiveRecord::Migration[6.0]
  def change
    remove_index :comments, :topic_id
    remove_index :comments, :user_id
    add_index :comments, [:topic_id, :user_id]
  end
end
