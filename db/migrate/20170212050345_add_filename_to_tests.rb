# frozen_string_literal: true
class AddFilenameToTests < ActiveRecord::Migration[5.0]
  def change
    add_column :tests, :filename, :string
  end
end
