# frozen_string_literal: true

class AddRefreshTokenToIdentity < ActiveRecord::Migration[5.0]
  def change
    add_column :identities, :refreshtoken, :string
  end
end
