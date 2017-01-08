# frozen_string_literal: true
class AddTeamIdToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_reference :submissions, :team, index: true
  end
end
