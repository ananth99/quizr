class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.belongs_to :user
      t.integer    :score
      t.timestamps
    end
  end
end
