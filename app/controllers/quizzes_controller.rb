class QuizzesController < ApplicationController
  before_filter :authenticate_user!
  $question_number = 1
  def new
    @question = Question.new.random_question
    @quiz = Quiz.find_by(:user_id => current_user.id, :session => session['session_id'])
    # flash[:notice] = @quiz.score if !@quiz.blank?
    if @quiz.blank?
      $question_number = 1
      @quiz = Quiz.new
      @quiz.user_id = current_user.id
      @quiz.session = session['session_id']
      @quiz.save!
    elsif @quiz.quiz_completed?
      redirect_to results_quiz_path
    end
  end

  def submit
    begin
      option = Option.find(params[:options])
      @quiz = Quiz.find_by(:user_id => params[:quiz_user], :session => params[:quiz_session])
      # flash[:alert] = $question_number.inspect
      if $question_number < 5
        if option.answer?
          @quiz.update(score: @quiz.correct_answer)
        else
          @quiz.update(score: @quiz.wrong_answer)
        end
        $question_number +=1
        redirect_to root_path
      else
        # raise $question_number.inspect
        @quiz.update(quiz_completed: true)
        redirect_to results_quiz_path
      end
    rescue Exception => e
      redirect_to root_path, notice: "Option cannot be blank!" 
    end

  end

  def results
    @quizzes = Quiz.where(:user_id => current_user.id, :quiz_completed => true).order('created_at desc')
  end
end
