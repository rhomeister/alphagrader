class Test < ApplicationRecord
  belongs_to :assignment
  has_many :test_results

  validates :name, presence: true
end
