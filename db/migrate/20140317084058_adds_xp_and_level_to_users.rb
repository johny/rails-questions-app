class AddsXpAndLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :xp_points, :integer, default: 0
    add_column :users, :level, :integer, default: 1
  end
end
