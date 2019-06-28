# frozen_string_literal: true

class AddSecretTokenToIdentity < ActiveRecord::Migration[5.0]
  def change
    add_column :identities, :secrettoken, :string
  end
end
