class AddsRelationBetweenQuestionsAndQuizzes < ActiveRecord::Migration
  def up

    create_table :questions_quizzes, id: false do |t|
      t.references :question
      t.references :quiz
    end

  end
end
