# frozen_string_literal: true

class AddUniqueIndexToMembership < ActiveRecord::Migration[5.0]
  def change
    add_index :memberships, %i[user_id course_id], unique: true
  end
end
