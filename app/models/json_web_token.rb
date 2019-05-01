class JsonWebToken
	
	SECRET_KEY = Rails.application.credentials.secret_key_base.to_s

	def self.encode(payload)
		expiration  = 30.minutes.from_now.to_i
		payload_lmt = payload.merge(exp: expiration.to_i) 
		JWT.encode(payload_lmt, SECRET_KEY)
	end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new decoded
	end

end


	# https://medium.com/binar-academy/rails-api-jwt-authentication-a04503ea3248 
	# https://nebulab.it/blog/authentication-with-rails-jwt-and-react/
	# https://dev.to/codemy/ruby-on-rails-api-authentication-2374