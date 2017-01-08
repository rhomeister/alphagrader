class CreateMembershipsTeamsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_table :memberships_teams, id: false do |t|
      t.references :membership, index: true, foreign_key: true
      t.references :team, index: true, foreign_key: true
    end
  end
end
