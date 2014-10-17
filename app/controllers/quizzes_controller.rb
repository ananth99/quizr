class QuizzesController < ApplicationController
  before_filter :authenticate_user!
  @@question = 0
  def new
    @questions = Question.new.random_question
    @quiz = Quiz.new
    @quiz.user_id = current_user.id
    @quiz.session = session['session_id']
  end

  def results

  end

  def submit
    option = Option.find(params[:options])
    if @@question < 5
      raise params.inspect
      if option.answer?
        @quiz.score += 2
      else
        @quiz.score -= 1
      end
    end
  end
end
