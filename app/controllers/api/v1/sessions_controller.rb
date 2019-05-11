module Api::V1 
  class SessionsController < ApiController

    def show 
      current_user ? head(:ok) : head(:unauthorized)
    end

  	def create
  		@user = User.where(email: params[:email]).first
  		if @user&.valid_password?(params[:password])
  			#render json: @user.as_json(only: [:email, :authentication_token]), status: :created
        render :create, status: :created
      else 
  			head(:unauthorized)
  		end
  	end 

  	def destroy
      current_user&.authentication_token = nil
      if current_user.save
        head(:ok)
      else 
        head(:unauthorized)
      end
  	end

  end
end