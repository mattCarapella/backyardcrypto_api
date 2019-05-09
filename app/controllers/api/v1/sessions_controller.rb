module Api::V1 
  class SessionsController < ApiController

  	def create
  		user = User.where(email: params[:email]).first
      p "***** USER: " 
  		if user&.valid_password?(params[:password])
        p "^^^^ USER IS VALID"
  			render json: user.as_json(only: [:email, :authentication_token]), status: :created
      else 
        p "^^^^ USER IS *NOT* VALID"
  			head(:unauthorized)
  		end
  	end 

  	def destroy

  	end

  end
end