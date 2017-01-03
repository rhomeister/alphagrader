# frozen_string_literal: true
class AddRefreshTokenToIdentity < ActiveRecord::Migration
  def change
    add_column :identities, :refreshtoken, :string
  end
end
