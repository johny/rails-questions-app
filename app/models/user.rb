class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :authentications
  has_many :games
  has_many :quizzes, through: :games


  def self.new_from_oauth data

    user = User.new({
      email: data['info']['email'],
      name: data['info']['name'],
      password: Devise.friendly_token[0,10]
    })

    auth = Authentication.new({
      provider: data['provider'],
      uid: data['uid'],
      token: data['credentials'].token
    })

    auth.token_secret = data['credentials'].secret unless data['credentials'].token_secret.blank?
    auth.refresh_token = data['credentials'].refresh_token unless data['credentials'].refresh_token.blank?
    auth.expires_at = data['credentials'].expires_at unless data['credentials'].expires_at.blank?
    auth.expires =  data['credentials'].expires unless data['credentials'].expires.blank?
    auth.image = data['info'].image unless data['info'].image.blank?


    user.authentications << auth
    user.save!

    return user

  end

end
