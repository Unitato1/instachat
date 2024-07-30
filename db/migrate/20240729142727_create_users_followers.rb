class CreateUsersFollowers < ActiveRecord::Migration[7.1]
  def change
    create_table :users_followers do |t|
      t.references :user, null: false
      t.references :follower, foreign_key: { to_table: :users }, null: false
      t.string :status

      t.timestamps
    end
  end
end
