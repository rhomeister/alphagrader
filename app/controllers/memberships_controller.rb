# frozen_string_literal: true

class MembershipsController < ApplicationController
  load_and_authorize_resource

  def update
    if @membership.update(membership_params)
      redirect_to @membership.course
    else
      render 'edit'
    end
  end

  def destroy
    @membership.destroy
    redirect_to @membership.course
  end

  private

  def membership_params
    params.require(:membership).permit(:instructor)
  end
end
