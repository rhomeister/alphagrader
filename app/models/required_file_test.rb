# frozen_string_literal: true
class RequiredFileTest < Test
  validates :filename, presence: true

  def run(submission)
    directory = submission.tempdir
    status = File.exists?(directory + '/' + filename) ? 'success' : 'failure'
    RequiredFileTestResult.new(status: status,
                               name: name,
                               filename: filename,
                               public: public)
  end
end
