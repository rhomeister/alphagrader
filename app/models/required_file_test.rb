# frozen_string_literal: true
class RequiredFileTest < Test
  validates :filename, presence: true

  def self.description
    [:required_file_test, {
      name: RequiredFileTest.model_name.human,
      description: 'Checks whether a file is present.',
      class: RequiredFileTest
    }]
  end

  def self.detailed_description
    description.last.fetch(:description)
  end

  def run(submission)
    directory = submission.tempdir
    status = File.exist?(directory + '/' + filename) ? 'success' : 'failure'
    RequiredFileTestResult.new(status: status,
                               name: name,
                               filename: filename,
                               public: public)
  end
end
