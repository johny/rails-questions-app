class AddsWorkflowToGames < ActiveRecord::Migration
  def change
    add_column :games, :workflow_state, :string
    add_index :games, :workflow_state, :unique => false
  end
end
