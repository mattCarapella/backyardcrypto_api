module Api::V1 	
	class GenresController < ApiController

		before_action :set_genre, only: [:show, :destroy ]

		def index
			@genres = Genre.all.each_slice(4).to_a
		end

		def show
			@genre = Genre.friendly.find(params[:id])
			@coins_in_genre = @genre.coins
			@coins_in_genre_ = @coins_in_genre.where("accepted=?", true)
			@missing_pictures = @coins_in_genre_.where("picture=?", nil)
			@missing_pictures.each do |c| 
				c.picture = get_submitted_picture(c)
				c.save!
			end
		end

		private

			def genre_params
				params.require(:genre).permit(:name, :displayname)
			end

			def set_genre
				@genre = Genre.friendly.find(params[:id])
			end

      def get_submitted_picture
        cryptocompare_response = HTTParty.get("https://www.cryptocompare.com/api/data/coinlist/")
        if cryptocompare_response.present?
          if cryptocompare_response['Data']      
            if c.currency_abbrev.present? && cryptocompare_response['Data'][c.currency_abbrev.upcase] && cryptocompare_response['Data'][c.currency_abbrev.upcase].values[5].downcase == c.currency_name.downcase
                @img_url_ = cryptocompare_response['BaseImageUrl'] + cryptocompare_response['Data'][c.currency_abbrev.upcase]['ImageUrl']
            end
          end
        end
        @found = Picture.find_by(coin_id: c.id, accepted: true)
        if @found
          return @found.image.url
        elsif @img_url_
          return @img_url_
        else
          return nil
        end
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
