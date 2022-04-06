# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  failed_attempts        :integer          default(0), not null
#  unlock_token           :string
#  locked_at              :datetime
#  name                   :string
#  provider               :string
#  uid                    :string
#
class User < ApplicationRecord
  has_many :listings, foreign_key: :host_id

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
