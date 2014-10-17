class QuizzesController < ApplicationController
  before_filter :authenticate_user!
  @@question_number = 0
  def new
    @question = Question.new.random_question
    @quiz = Quiz.find_by(:user_id => current_user.id, :session => session['session_id'])
    if @quiz.blank?
      @quiz = Quiz.new
      @quiz.user_id = current_user.id
      @quiz.session = session['session_id']
      @quiz.save!
    elsif @quiz.quiz_completed?
      redirect_to results_quiz_path
    else
      render 'new'
    end
  end

  def submit
    option = Option.find(params[:options])
    @quiz = Quiz.find_by(:user_id => params[:quiz_user], :session => params[:quiz_session])
    if @@question_number < 4
      if option.answer?
        @quiz.update(score: @quiz.correct_answer)
      else
        @quiz.update(score: @quiz.wrong_answer)
      end
      @@question_number +=1
      puts "question no: #{@@question_number.inspect}"
      redirect_to :back
    else
      @quiz.update(quiz_completed: true)
      redirect_to results_quiz_path
    end

  end

  def results
    @quizzes = Quiz.where(:user_id => current_user.id, :quiz_completed => true).order('created_at desc')
  end
end
