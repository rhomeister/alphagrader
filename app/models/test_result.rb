class TestResult < ApplicationRecord
  belongs_to :test
  belongs_to :submission

  enum status: [:success, :failure, :error]
end
