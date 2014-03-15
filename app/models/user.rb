class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :authentications
  has_many :games
  has_many :quizzes, through: :games

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/images/:style/avatar.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/


  def avatar_remote_url=(url)
    self.avatar = URI.parse(url)
  end

  def self.find_or_create_from_oauth data

    user = User.find_or_initialize_by(email: data['info']['email'])

    if user.new_record?
      user.name = data['info']['name']
      user.password = Devise.friendly_token[0,10]
      user.avatar = URI.parse(data['info']['image']) if data['info']['image']
    end

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

  def set_avatar_from_url! url

    if url.match(/facebook/)
      r = open("http://graph.facebook.com/#{@user.facebook_id}/picture")

      self.avatar = open(url)
      self.avatar_content_type = "image/jpeg"
      return self.save(validate: false)
    else
      self.avatar = open(URI.parse(url))
      return self.save
    end
  end


end
