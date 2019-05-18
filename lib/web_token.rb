module WebToken
	SECRET = Rails.application.secrets.secret_key_base
	EXPIRE = (Time.now + 1.days).to_i

	class << self 

		def encode(user)
			JWT.encode(token_params(user), WebToken::SECRET, 'HS256')
		end

		def decode(token)
			JWT.decode(token, WebToken::SECRET, true, { algorithm: 'HS256' }).first
		rescue JWT::ExpiredSignature
		  :expired
		end

		private 

			def token_params(user)
				{ user_id: user.id, exp: EXPIRE }
			end

	end
end