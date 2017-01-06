class AddGithubRepositoryNameToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :github_repository_name, :string, index: true
  end
end
