class Quiz < ActiveRecord::Base
  belongs_to :user

  def correct_answer
    self.score += 2
  end

  def wrong_answer
    self.score -= 1
  end
end
