class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|

      t.string :name
      t.string :description

      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.string :workflow_state

      t.timestamps
    end

    add_index :topics, :workflow_state, :unique => false
    add_index :topics, :parent_id, :unique => false
    add_index :topics, :lft, :unique => false
    add_index :topics, :rgt, :unique => false
    add_index :topics, :depth, :unique => false

  end
end
