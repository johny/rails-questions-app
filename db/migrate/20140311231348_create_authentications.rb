class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :user

      t.string :provider
      t.string :uid
      t.string :token
      t.string :refresh_token
      t.datetime :expires_at
      t.boolean :expires
      t.string :image

      t.timestamps
    end

    add_index :authentications, :provider, :unique => false
    add_index :authentications, :uid, :unique => true

  end
end
