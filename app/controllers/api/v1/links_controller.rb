module Api::V1 
  class LinksController < ApiController
    before_action :set_link, except: [:new, :create, :index]
    before_action :set_coin, only: [index, :create]
  	# before_action :authenticate_user!
  	# load_and_authorize_resource

    def index
      @pending_links  = @coin.links.where("active_status=?", 0)
      @accepted_links = @coin.links.where("active_status=?", 1)
      @inactive_links = @coin.links.where("active_status=?", 2)
      @pending_count  = @pending_links.size
      @accepted_count = @accepted_links.size
      @inactive_count = @inactive_links.size 
    end

    def new
      @link = current_user.links.build
    end

  	def create
  	  # @link = current_user.links.build(link_params)
  	  @link = Link.new(link_params)
      @link.coin = @coin
  	  if @link.save
  	  	render json: @link, status: :created
  	  else
  	    render json: @link.errors, status: :unprocessable_entity
      end
  	end

    def update
    	# authorize! :update, @link
      if @link.update(link_params)
        render json: @link, status: :ok   
      else
        render json: @link.errors, status: :unprocessable_entity   
      end
    end	

    def destroy
    	# authorize! :destroy, @link
      @link = Link.find(params[:id])
      @link.destroy
    end

    def activate
      # authorize! :update, @link
      @link.active_status = 1
      @link.save!
    end

    def deactivate
      # authorize! :update, @link   
      @link.active_status = 2
      @link.save!
    end

    private

      def link_params
        params.require(:link).permit(:url, :websitename, :accepted, :link_type, :exchange, :description, :active_status)
      end

      def set_link
        @link = Link.find(params[:id]) 
      end

      def set_coin 
        @coin = Coin.friendly.find(params[:coin_id])
      end
          
  end
end
