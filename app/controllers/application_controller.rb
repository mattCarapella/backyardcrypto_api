class ApplicationController < ActionController::API

  #acts_as_token_authentication_handler_for User, fallback: :none

	private 

  	def configure_permitted_parameters
      added_attrs = [:terms_of_service, :username, :email, :password, :password_confirmation, :fname, :lname, :wallet,
                    :admin, :moderator, :currentbalance, :payout_to_date, :bio, :facebook, :twitter, :instagram, :linkedin,
                    :youtube, :personal_website, :id_photo, :authentication_token]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end	

    def user_params
      params.require(:user).permit(:email, :terms_of_service, :username, :password, :password_confirmation, :fname,:lname, :wallet, :admin, :moderator, :currentbalance, :payout_to_date, :bio, :facebook, :twitter, :instagram, :linkedin, :youtube, :personal_website, :authentication_token) if params[:user].present?
    end

    # def sign_up_params
    #   params.require(:user).permit(:name, :terms_of_service, :username,:age, :password,:password_confirmation, :remember_me,:fname, :lname, :wallet, :admin, :moderator, :currentbalance, :payout_to_date, :bio, :facebook, :twitter, :instagram, :linkedin, :youtube, :personal_website, :id_photo) if params[:user].present?
    # end

end
