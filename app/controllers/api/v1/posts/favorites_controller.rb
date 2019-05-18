module Api::V1  
	class Posts::FavoritesController < ApiController 
		#before_action :authenticate_user! 
		before_action :set_post

		def create
			@post.favorites.where(user_id: current_user.id).first_or_create
			respond_to do |format| 
				# format.html { redirect_to @post }
				format.js 
			end
		end

		def destroy
			@post.favorites.where(user_id: current_user.id).destroy_all
			respond_to do |format| 
				# format.html { redirect_to @post }
				format.js
			end
		end

		private 

			def set_post 
				@post = Post.find(params[:post_id])
			end
	end
end