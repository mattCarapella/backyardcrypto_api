class ApiController < ApplicationController
	
	before_action :set_default_format 
	before_action :authenticate_user! 
	#before_action :authenticate_token!

	private 

		def set_default_format
			request.format = :json
		end

		# def authenticate_token! 
		# 	auth_token = request.headers['Authorization']
		# 	auth_token = auth_token.split(' ').last if auth_token
		# 	payload = JsonWebToken.decode(auth_token)
		# 	@current_user = User.find(payload["sub"])
		# 	rescue ActiveRecord::RecordNotFound => e
  	#     render json: { errors: ["***** ERROR: RECORD NOT FOUND *****"] }, status: :unauthorized
  	#   rescue JWT::ExpiredSignature
		# 		render json: { errors: ["***** ERROR: AUTH TOKEN HAS EXPIRED *****"]}, status: :unauthorized
  	#   rescue JWT::DecodeError => e
		# 		render json: { errors: ["***** ERROR: INVALID AUTH TOKEN *****"] }, status: :unauthorized
		# end

end