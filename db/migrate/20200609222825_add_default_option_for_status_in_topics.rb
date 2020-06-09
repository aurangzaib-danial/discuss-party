class AddDefaultOptionForStatusInTopics < ActiveRecord::Migration[6.0]
  def change
    change_column :topics, :status, :integer, default: 0
  end
end
