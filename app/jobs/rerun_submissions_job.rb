class RerunSubmissionsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    @submissions.each(&:rerun_tests)
    flash[:success] = 'All submissions have been enqueued for rechecking'
  end
end
