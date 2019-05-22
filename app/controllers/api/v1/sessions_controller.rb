module Api::V1 
  class SessionsController < ApiController

    def show 
      current_user ? head(:ok) : head(:unauthorized)
    end

  	def create
  		@user = User.where(email: params["user"][:email]).first
  		if @user&.valid_password?(params["user"][:password])
        puts "SIGNED IN *******"
        jwt = ''
        jwt = WebToken.encode(@user)
        render :create, locals: { token: jwt }, status: :created
      else 
  			render json: { error: 'invalid_credentials' }, status: 401
  		end
  	end 

  	def destroy
      #current_user&.authentication_token = nil
      #if current_user.save 
      #  head(:ok)
      #else 
      #  head(:unauthorized)
      #end
  	end

  end
end