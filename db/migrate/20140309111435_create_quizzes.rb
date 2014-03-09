class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|

      t.string :title
      t.string :description

      t.date :date

      t.string :type
      t.string :workflow_state

      t.timestamps
    end

    add_index :quizzes, :type, :unique => false
    add_index :quizzes, :workflow_state, :unique => false
  end
end
