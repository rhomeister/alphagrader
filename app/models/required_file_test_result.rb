# frozen_string_literal: true

class RequiredFileTestResult < TestResult
  def test_type
    RequiredFileTest
  end

  def file_url
    submission.file_url(filename)
  end
end
