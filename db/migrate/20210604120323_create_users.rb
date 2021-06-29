class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :access_token
      t.string :login
      t.integer :git_id
      t.text :avatar_url
      t.text :url
      t.text :organisations_url
      t.text :received_events_url
      t.string :name
      t.string :company
      t.text :blog
      t.string :location
      t.string :email
      t.text :bio
      t.datetime :github_account_created_at
      t.string :twitter_username

      t.timestamps
    end
    add_index :users, [:login, :git_id, :email], unique: true
  end
end
