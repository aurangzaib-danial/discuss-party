class CreateReports < ActiveRecord::Migration[6.0]
  def change
    create_table :reports do |t|
      t.bigint :topic_id, null: false
      t.bigint :user_id, null: false
      t.integer :report_type, null: false

      t.timestamps
    end
    add_foreign_key :reports, :topics
    add_foreign_key :reports, :users
    add_index :reports, [:user_id, :topic_id], unique: true
  end
end
