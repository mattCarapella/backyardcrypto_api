module Devise
	module Strategies
		class JWTAuthenticatable < Base

			def authenticate!
				token = get_token
				p "**** TOKEN: " + token if token
				return fail(:invalid) unless token.present? && token != "null"
				payload = WebToken.decode(token)

				return fail(:invalid) if payload == :expired
				resource = mapping.to.find(payload['user_id'])
				return fail(:not_found_in_database) unless resource
				success! resource
				#p "******************** AUTHENTICATED"
			end

			private 

				def get_token
					auth_header.present? && auth_header.split(' ').last
				end
		
				def auth_header
					request.headers['Authorization']
				
				end
		end
	end
end