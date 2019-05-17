module Api::V1    
  class PicturesController < ApiController
    # load_and_authorize_resource
  	before_action :set_coin 
  	# before_action :set_user
    # before_action :find_pictures

    def index
      #authorize! :index, @picture
      #@accepted, @pending = @coin.pictures.partition(&:accepted)
      @pending  = @coin.pictures.where("active_status=?", 0) 
      @accepted = @coin.pictures.where("active_status=?", 1) 
      @inactive = @coin.pictures.where("active_status=?", 2) 
      @main_pic = @accepted.first
    end

  	def show
    	#authorize! :read, @picture
      @picture = Picture.find(params[:id])
    end

    def new
      #@picture = current_user.pictures.build
      @picture = Picture.new(picture_params)
    end

  	def create
      # authorize! :create, @picture
      #@picture = current_user.pictures.build(picture_params)
      @picture = Picture.new(picture_params)
      @picture.coin = @coin
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
      @picture = Picture.find(params[:id]) 
      @picture.destroy
    end

    def activate
      #authorize! :update, @picture
      picture = Picture.find(params[:id])
      if picture.valid? :activate
        if picture.active_status == 0 or picture.active_status == 2
          picture.active_status = 1
          picture.save!
        end
      end   
    end

    def deactivate
      #authorize! :update, @picture
      picture = Picture.find(params[:id])    
      if picture.active_status == 0 or picture.active_status == 1
        picture.active_status == 2
        picture.save!
      end      
    end

  	private 

      def find_pictures 
        @pictures = Picture.where(coin_id: @coin.id).order("created_at DESC")
      end

      def picture_params
        params.require(:picture).permit(:image, :description, :accepted, :pending, :rejected, :active_status)
      end

  		def set_coin
        @coin = Coin.friendly.find(params[:coin_id])
      end

      # def set_user
      #   @user = current_user
      # end
  end
end
