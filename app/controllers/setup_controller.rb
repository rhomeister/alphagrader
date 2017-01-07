# frozen_string_literal: true
require 'rdiscount'
class SetupController < ApplicationController
  skip_authorization_check
  before_action :require_local!
  layout :false

  def index
    file = Rails.env.development? ? '.env' : ".env.#{Rails.env}"
    @env = File.read(File.join(Rails.root, file))
    @docs = files
  end

  protected

  def require_local!
    redirect_to root_url, error: 'This information is only available to local requests' unless local_request?
  end

  def local_request?
    Rails.application.config.consider_all_requests_local || request.local?
  end

  def files
    Dir.glob(File.join(Rails.root, 'docs/README.*')).collect do |file|
      name = file.gsub(/.*README.\d\d./, 'happy_seed:').gsub(/.rdoc/, '')
      html = RDiscount.new(File.read(file)).to_html
      { name: name, html: html }
    end
  end
end
