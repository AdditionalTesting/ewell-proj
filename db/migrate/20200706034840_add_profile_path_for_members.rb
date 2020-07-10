class AddProfilePathForMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :profile_path, :string
  end
end
