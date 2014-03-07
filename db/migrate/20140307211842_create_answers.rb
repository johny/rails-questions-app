class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|

      t.references :question
      t.text :content
      t.boolean :is_correct, default: false

      t.timestamps
    end
  end
end
