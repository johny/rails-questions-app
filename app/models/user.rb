class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :authentications
  has_many :games
  has_many :quizzes, through: :games
  has_many :replies

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
    :default_url => "/images/:style/avatar.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  before_create :set_initial_title
  before_save :calculate_xp_level

  scope :ranking, -> { order(daily_quiz_score: :desc)}

  def avatar_remote_url=(url)
    self.avatar = URI.parse(url)
  end

  def friendly_title
    "Początkujący" if title == "beginner"
  end

  def score
    return daily_quiz_score
  end

  def ranking_position
    ranking = User.ranking.select(:id).collect { |u| u.id }
    return ranking.index(id) + 1
  end

  def correct_answers_percentage
    total = replies.size.to_f
    correct = replies.where(is_correct: true).size.to_f
    return "0%" if total == 0
    return "#{((correct / total) * 100).to_i}%"
  end

  def average_response_time
    average = replies.average(:time)
    return "#{average} s"
  end

  def xp_for_next_level
    xp = (Rules.base_xp_per_level * (level + 0.15 * (self.level - 1))).to_i
    return xp
  end

  def xp_bar_percentage
    return "#{((xp_points.to_f / xp_for_next_level.to_f) * 100).to_i}%"
  end

  def count_game_score(game)
    # update user scrore
    self.daily_quiz_score += game.score

    # update xp
    self.xp_points += game.score

    # +25% bonus if quiz was completed 100% correct
    if game.correct_replies_percentage == 100
      self.xp_points += (game.score * 0.25).to_i
    end

    self.save!
  end

  def calculate_xp_level
    if xp_points > xp_for_next_level
      level += 1
    end
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

  private
    def set_initial_title
      title = "beginner"
    end


end
