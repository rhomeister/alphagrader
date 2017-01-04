class AddUniqueIndexToMembership < ActiveRecord::Migration[5.0]
  def change
    add_index :memberships, [:user_id, :course_id], unique: true
  end
end
