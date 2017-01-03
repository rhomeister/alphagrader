# frozen_string_literal: true
class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :course

  enum role: [:user, :instructor]
end
