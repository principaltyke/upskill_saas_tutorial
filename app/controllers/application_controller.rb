class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  #whitelist the following form fields so that we can process them, if coming from 
  #a devise sign up form
  before_action :configure_permitted_parameters,  if: :devise_controller?   #if a user submits a form from devise using the devise controller, then run configure_permitted_parameters
  
  protected 
    def configure_permitted_parameters
        #|u| refers to user
         devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:stripe_card_token, :email, :password, :password_confirmation) } #whitelist because we have added additional fields from the orignal devise form
    end
end
