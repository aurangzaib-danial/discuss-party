class CreateOauthIdentities < ActiveRecord::Migration[6.0]
  def change
    create_table :oauth_identities do |t|
      t.bigint :uid
      t.string :provider
      t.bigint :user_id, null: :false
      t.timestamps
    end
    add_foreign_key :oauth_identities, :users, on_update: :cascade, on_delete: :cascade
    add_index :oauth_identities, [:user_id, :provider], unique: true
  end
end
