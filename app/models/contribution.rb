# frozen_string_literal: true
class Contribution < ApplicationRecord
  belongs_to :membership, inverse_of: :contributions
  belongs_to :submission, inverse_of: :contributions
end
