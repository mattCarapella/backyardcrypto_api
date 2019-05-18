module Api::V1 
  class SessionsController < ApiController

    def show 
      current_user ? head(:ok) : head(:unauthorized)
    end

  	def create
  		@user = User.where(email: params[:email]).first
  		if @user&.valid_password?(params[:password])
        jwt=''
        p "**** t1: " + jwt
          jwt = WebToken.encode(@user)
          p '***** t2: ' + jwt
        render :create, locals: { token: jwt }, status: :created
      else 
  			render json: { error: 'invalid_credentials' }, status: :unauthorized
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