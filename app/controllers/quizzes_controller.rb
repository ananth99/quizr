class QuizzesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @questions = Question.all
  end

  def results
    
  end
end
