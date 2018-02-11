# frozen_string_literal: true

class AddFileToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_attachment :submissions, :file
    add_column :submissions, :file_fingerprint, :string
  end
end
