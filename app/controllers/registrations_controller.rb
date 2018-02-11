# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    if resource.encrypted_password.blank? # || params[:password].blank?
      resource.email = params[:email] if params[:email]
      if params[:password].present? && params[:password] == params[:password_confirmation]
        logger.info 'Updating password'
        resource.password = params[:password]
        resource.save
      end
      resource.update_without_password(params) if resource.valid?
    else
      resource.update_with_password(params)
    end
  end

  def destroy
    raise 'cannot destroy account!'
  end

  private

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :instructor)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password)
  end
end
