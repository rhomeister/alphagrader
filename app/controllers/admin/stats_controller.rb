# frozen_string_literal: true

module Admin
  class StatsController < ApplicationController
    before_action :authenticate_admin_user!
    skip_authorization_check

    def stats
      if params[:scope].blank?
        render json: { errors: 'scope not set' }, status: :unprocessable_entity
      else
        cls = User
        cls = Identity.where('provider = ?', 'twitter') if params[:scope] == 'twitter_users'
        cls = Identity.where('provider = ?', 'instagram') if params[:scope] == 'instagram_users'
        ret = cls.group_by_month
        render json: ret
      end
    end
  end
end
