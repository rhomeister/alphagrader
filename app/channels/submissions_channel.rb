# frozen_string_literal: true

class SubmissionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "submissions_#{current_user.id}"
  end
end
