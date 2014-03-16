class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|

      t.references :user
      t.references :game
      t.references :question
      t.references :answer
      t.boolean :is_correct, default: false

      t.integer :time

      t.timestamps
    end
  end
end
