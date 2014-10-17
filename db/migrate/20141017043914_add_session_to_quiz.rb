class AddSessionToQuiz < ActiveRecord::Migration
  def change
    add_column :quizzes, :session, :string
  end
end
