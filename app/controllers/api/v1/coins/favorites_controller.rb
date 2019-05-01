module Api::V1  	
	class Coins::FavoritesController < ApiController 
		#before_action :authenticate_user! 
		before_action :set_coin, except: [:index]

		def create
			@coin.favorites.where(user_id: current_user.id).first_or_create
			respond_to do |format| 
				format.html { redirect_to @coin }
				format.js
			end
		end

		def destroy
			@coin.favorites.where(user_id: current_user.id).destroy_all
			respond_to do |format| 
				format.html { redirect_to @coin }
				format.js
			end
		end

		private 

			def set_coin 
				@coin = Coin.friendly.find(params[:coin_id])
			end
	
	end
end