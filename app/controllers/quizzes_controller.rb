class QuizzesController < ApplicationController
  before_filter :authenticate_user!
  $question_number = 1
  def new
    # raise session['session_id'].inspect
    Rails.logger.warn "question_number= #{$question_number}"
    @question = Question.new.random_question
    @quiz = Quiz.find_by(:user_id => current_user.id, :session => session['session_id'])
    # raise @quiz.inspect
    if @quiz.blank?
      $question_number = 1
      @quiz = Quiz.new
      @quiz.user_id = current_user.id
      @quiz.session = session['session_id']
      @quiz.save!
      render 'new'
    elsif @quiz.quiz_completed?
      # raise $question_number.inspect
      redirect_to results_quiz_path
    end
  end

  def submit
    # Rails.logger.warn "question_number= #{$question_number}"
    option = Option.find(params[:options])
    @quiz = Quiz.find_by(:user_id => params[:quiz_user], :session => params[:quiz_session])
    if $question_number < 5
      if option.answer?
        @quiz.update(score: @quiz.correct_answer)
      else
        @quiz.update(score: @quiz.wrong_answer)
      end
      $question_number +=1
      puts "question no: #{$question_number.inspect}"
      redirect_to root_path
    else
      # raise $question_number.inspect
      @quiz.update(quiz_completed: true)
      redirect_to results_quiz_path
    end

  end

  def results
    @quizzes = Quiz.where(:user_id => current_user.id, :quiz_completed => true).order('created_at desc')
  end
end
