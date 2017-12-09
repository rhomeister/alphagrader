# frozen_string_literal: true
class Test < ApplicationRecord
  belongs_to :assignment
  has_many :test_results

  validates :name, presence: true

  def self.help_page_url
    description.last[:help_page_url]
  end

  def self.valid_test_types
    [ExpectedOutputTest, AuthorContributionTest,
     RegexpOutputTest, RequiredFileTest].map(&:description).to_h
  end
end
