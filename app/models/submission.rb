# frozen_string_literal: true
class Submission < ApplicationRecord
  belongs_to :assignment
  belongs_to :uploaded_by, class_name: 'User'

  has_and_belongs_to_many :authors, class_name: 'User',
                                    join_table: :author_submissions,
                                    association_foreign_key: :author_id,
                                    inverse_of: :submissions
end
