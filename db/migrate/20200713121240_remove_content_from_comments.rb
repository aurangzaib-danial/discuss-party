class RemoveContentFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :content, :text
  end
end
