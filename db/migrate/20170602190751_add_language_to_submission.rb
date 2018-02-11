# frozen_string_literal: true

class AddLanguageToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :language, :string
  end
end
