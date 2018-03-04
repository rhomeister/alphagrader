# frozen_string_literal: true

class TestResult < ApplicationRecord
  belongs_to :test
  belongs_to :submission, counter_cache: true

  enum status: %i[success failure error skipped]

  def success_or_skipped?
    success? || skipped?
  end
end
