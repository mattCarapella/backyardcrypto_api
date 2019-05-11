module Api::V1    
  class PicturesController < ApiController
    # load_and_authorize_resource
  	before_action :set_coin 
  	# before_action :set_user
    # before_action :find_pictures

    def index
      #authorize! :index, @picture
      @pictures = @coin.pictures
      @accepted, @pending = @pictures.partition(&:accepted)
      @main_pic = @accepted.first
    end

  	def show
    	#authorize! :read, @picture
    end

    def new
      #@picture = current_user.pictures.build
    end

  	def create
      #authorize! :create, @picture
     #  params[:picture][:accepted] = false
  	  # @picture = current_user.pictures.build(picture_params)
  	  # @picture.coin = @coin

  	  # if @picture.save!
  	  #   redirect_to coin_path(@coin.id)
  	  # else
  	  #   render 'new'
  	  # end

      @picture = Picture.new 
      if @picture.save 
        render json: @picture, status: :created
      end
  	end

    def edit
    end

    def update
    end	

    def destroy
    	#authorize! :destroy, @picture
      @picture.destroy
      #redirect_to coin_path(@coin.id)
    end

    def activate
      #authorize! :update, @picture
      picture = Picture.find(params[:id])
      if picture.valid? :activate
        if !picture.accepted?
          picture.accepted = true
          picture.pending = false
          picture.rejected = false
          picture.save
          #redirect_to request.referrer
        end
      else 
        flash[:notice] = "Sorry. There can only be one approved picture."
        #redirect_to request.referrer
      end   
    end

    def deactivate
      #authorize! :update, @picture
      picture = Picture.find(params[:id])    
      if picture.accepted?
        picture.accepted = false
        picture.pending = true
        picture.rejected = false
      end
      picture.save
      #redirect_to request.referrer
    end

  	private 

      def find_pictures 
        @pictures = Picture.where(coin_id: @coin.id).order("created_at DESC")
      end

      def picture_params
        params.require(:picture).permit(:image, :description, :accepted, :pending, :rejected)
      end

  		def set_coin
        @coin = Coin.friendly.find(params[:coin_id])
      end

      # def set_user
      #   @user = current_user
      # end
  end
end
