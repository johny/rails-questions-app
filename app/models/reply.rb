class Reply < ActiveRecord::Base

  belongs_to :user
  belongs_to :game
  belongs_to :question
  belongs_to :answer


  def self.from_user_for_game(user, game)
    where(user_id: user.id, game_id: game.id).first()
  end

end
