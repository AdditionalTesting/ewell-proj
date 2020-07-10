class CreateFriendships < ActiveRecord::Migration[6.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :member, foreign_key: true
      t.belongs_to :friend, foreign_key: {to_table: :members}

      t.timestamps
    end
  end
end
