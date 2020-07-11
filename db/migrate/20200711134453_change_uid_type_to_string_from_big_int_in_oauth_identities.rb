class ChangeUidTypeToStringFromBigIntInOauthIdentities < ActiveRecord::Migration[6.0]
  def change
    change_column :oauth_identities, :uid, :string
  end
end
