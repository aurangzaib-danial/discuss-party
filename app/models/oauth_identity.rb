class OauthIdentity < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id, scope: :provider
end
