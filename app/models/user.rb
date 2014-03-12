class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :authentications
  has_many :games
  has_many :quizzes, through: :games


  def self.new_from_facebook_oauth data

    user = User.new({
      email: data['info']['email'],
      name: data['info']['name'],
      password: Devise.friendly_token[0,10]
    })

    auth = Authentication.new({
      :provider => data['provider'],
      :uid => data['uid'],
      :token => data['credentials'].token,
      :token_secret => data['credentials'].secret
    })

    user.authentications << auth

    user.save!

    return user

  end

end
