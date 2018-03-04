# frozen_string_literal: true

class AddIndexOnLowercaseIdentities < ActiveRecord::Migration[5.0]
  def change
    add_index :identities, 'lower(email)', name: 'index_identities_on_lower_email'
    add_index :identities, 'lower(name)', name: 'index_identities_on_lower_name'
  end
end
