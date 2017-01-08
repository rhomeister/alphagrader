# frozen_string_literal: true
class DropAuthorSubmissionsJoinTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :author_submissions
  end
end
