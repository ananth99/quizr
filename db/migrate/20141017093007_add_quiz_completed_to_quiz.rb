class AddQuizCompletedToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :quiz_completed, :boolean, :default => false
  end
end
