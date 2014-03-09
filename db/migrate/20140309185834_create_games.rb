class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|

      t.references :user
      t.references :quiz

      t.integer :score, default: 0

      t.timestamps
    end
  end
end
