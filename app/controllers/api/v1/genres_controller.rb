module Api::V1 	
	class GenresController < ApiController

		before_action :find_genre, only: [:show, :edit, :update, :destroy ]

		def index
			@genres = Genre.all.each_slice(4).to_a
		end

		def new
		end

		def show
			@genre = Genre.friendly.find(params[:id])
			@coins_in_genre = @genre.coins
			@coins_in_genre_ = @coins_in_genre.where("accepted=?", true)
			@coins_in_genre_.each do |c| 
				# c.picture = get_submitted_picture(c)
				c.save!
			end
		end

		def new
			@genre = Genre.new
		end

		def create
			@genre = Genre.new(genre_params)
			if @genre.save
		    redirect_to genres_path
		  else
		    render 'new'
		  end
		end

		def update
		end

		def destroy
			authorize! :destroy, @genre
			@genre.destroy
			redirect_to genres_path
		end

		private

			def genre_params
				params.require(:genre).permit(:name, :displayname)
			end

			def find_genre
				@genre = Genre.friendly.find(params[:id])
			end

			def find_coin
				@coin = Coin.friendly.find(params[:id])
			end

	    # def get_submitted_picture (c)
	    #   cryptocompare_response = HTTParty.get("https://www.cryptocompare.com/api/data/coinlist/")
	    #   if cryptocompare_response['Data']
	    #     if c.currency_abbrev
	    #       @img_url_ = cryptocompare_response['BaseImageUrl'] + cryptocompare_response['Data'][c.currency_abbrev.upcase]['ImageUrl']
	    #     end
	    #   end
	    #   @found = Picture.find_by(coin_id: c.id, accepted: true)
	    #   if @found 
	    #     return @found.image.url 
	    #   elsif @img_url_
	    #     return @img_url_
	    #   else
	    #     return nil
	    #   end
	    # end

	end
end
