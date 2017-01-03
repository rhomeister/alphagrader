# frozen_string_literal: true
class ConfirmationsController < Devise::ConfirmationsController
  # Signin automatically if they come in through the link
  def show
    super do
      sign_in(resource) if resource.errors.empty?
    end
  end
end
