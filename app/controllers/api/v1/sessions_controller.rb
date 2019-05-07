module Api::V1 
  class SessionsController < ApiController

  	def create
  		user = User.where(email: params[:email]).first

  		if user&.valid_password?(params[:password])
  			render json: user.as_json(only: [:id, :email, :username, :authentication_token]), status: :created
      else 
  			head(:unauthorized)
  		end
  	end 

  	def destroy

  	end

  end
end