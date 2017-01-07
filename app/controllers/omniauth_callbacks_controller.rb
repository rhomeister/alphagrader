# frozen_string_literal: true
class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    generic_callback('facebook')
  end

  def google_oauth2
    generic_callback('google_oauth2')
  end

  def github
    generic_callback('github')
  end

  def twitter
    generic_callback('twitter')
  end

  def generic_callback(provider)
    identity = Identity.find_for_oauth request.env['omniauth.auth']

    set_user_fields

    if user.persisted?
      identity.update_attribute(:user_id, user.id)
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: provider.capitalize) if is_navigational_format?
    else
      session["devise.#{provider}_data"] = env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  private

  def identity
    @identity ||= Identity.find_for_oauth request.env['omniauth.auth']
  end

  def user
    return @user if @user

    @user = identity.user || current_user || User.find_by(email: identity.email)

    if @user.nil?
      @user = User.create(email: identity.email, oauth_callback: true, confirmed_at: Time.zone.now)
      @identity.update_attribute(:user_id, @user.id)
    end

    @user
  end

  def set_user_fields
    [:email, :name].each do |attr|
      user_value = user.send(attr)
      identity_value = identity.send(attr)

      if user_value.blank? && identity_value
        user[attr] = identity_value
      end
    end

    user.skip_confirmation_notification!
    user.save
    user.confirm
  end
end
