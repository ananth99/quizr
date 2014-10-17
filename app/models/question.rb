class Question < ActiveRecord::Base
  has_many :options

  self.per_page = 1

  def random_question
    return Question.limit(1).order('RANDOM()').first
  end
end
