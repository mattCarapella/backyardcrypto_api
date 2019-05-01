class Api::V1::AuthenticationController < ApiController 
	skip_before_action :authenticate_token!	# dont attempt to authenticate before an authentication token is created

	def create 
		# Create a JSON web token for user authentication
		user = User.find_by(email: params[:user][:email])
		if user.valid_password? params[:user][:password]
			render json: { token: JsonWebToken.encode(sub: user.id) }
		else 
			render json: { errors: ["Invalid email or password"] }
		end
	end

end