class AddDefaultScoreToQuiz < ActiveRecord::Migration
  def change
    change_column :quizzes, :score, :integer, :default => 0
  end
end
