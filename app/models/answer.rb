class Answer < ActiveRecord::Base

  belongs_to :question
  has_many :replies

  validates_presence_of :content, :message => "can't be blank"


  def correct?
    return is_correct
  end

end
