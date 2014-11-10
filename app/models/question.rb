class Question < ActiveRecord::Base
  has_many :options

  def random_question
    return Question.limit(1).order('RANDOM()').first
  end
end
