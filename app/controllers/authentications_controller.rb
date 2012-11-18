class AuthenticationsController < ApplicationController
  def create
    omniauth = request.env["omniauth.auth"]
    user = User.where(:email => omniauth.info.email).first || User.new
    user.email = omniauth.info.email
    user.facebook_uid = omniauth.uid
    if user.save
      sign_in :user, user
      redirect_to request.env["omniauth.origin"] || root_url
    end
  end
end