class AddCommitMessageToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :git_commit_message, :string
  end
end
