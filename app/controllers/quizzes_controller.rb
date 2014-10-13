class QuizzesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @questions = Question.all.paginate(:page => params[:page])
  end

  def results
  
  end

  def submit
    raise params.inspect
  end
end
