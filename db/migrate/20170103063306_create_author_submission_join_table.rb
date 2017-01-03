# frozen_string_literal: true
class CreateAuthorSubmissionJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :author_submissions, id: false do |t|
      t.references :author, index: true, foreign_key: { to_table: :users }
      t.references :submission, index: true, foreign_key: true
    end
  end
end
