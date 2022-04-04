class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable,
         :omniauthable, omniauth_providers: [:google]

  def self.from_omniauth(access_token)
    where(provider: access_token.provider, uid: access_token.uid).first_or_create do |user|
      user.name = access_token.info.name
      user.email = access_token.info.email
      user.password = Devise.friendly_token[0, 20]

      user.skip_confirmation!
    end
  end
end
