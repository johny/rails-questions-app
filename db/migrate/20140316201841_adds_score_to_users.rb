class AddsScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :daily_quiz_score, :integer, default: 0
  end
end
