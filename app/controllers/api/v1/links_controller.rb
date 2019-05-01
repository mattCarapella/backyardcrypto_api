module Api::V1 
  class LinksController < ApiController
    before_action :set_coin
    # before_action :set_user
    before_action :set_links, only: :index
    # before_action :partition_links
  	# before_action :authenticate_user!
  	# load_and_authorize_resource

    def index
      @accepted_links = Link.where("coin_id=? AND accepted=?", @coin.id, true).order("created_at DESC")
      @inactive_count = Link.where('coin_id=? AND rejected=?', @coin.id, true).count
      @pending_count  = Link.where('coin_id=? AND pending=?',  @coin.id, true).count
    end

    def new
      @link = current_user.links.build
    end

  	def create
      params[:link][:accepted] = false
  	  #@link = current_user.links.build(link_params)
  	  @link = Link.new(link_params)
      @link.coin = @coin
  	  if @link.save
  	  	render json: @link, status: :created
  	  else
  	    render json: @link.errors, status: :unprocessable_entity
      end
  	end

    def edit
    end

    def update
    	# authorize! :update, @link
      if @link.update(link_params)
        # redirect_to coin_link_path(@coin, @link.id)
      else
        # redirect_to 'edit'
      end
    end	

    def destroy
    	# authorize! :destroy, @link
      @link = Link.find(params[:id])
      @link.destroy
      # redirect_to coin_links_path
    end

    def activate
      # authorize! :update, @link
      link = Link.find(params[:id])
      link.accepted = true
      link.pending  = false
      link.rejected = false
      link.save
      # redirect_to request.referrer
    end

    def deactivate
      # authorize! :update, @link
      link = Link.find(params[:id])    
      link.accepted = false
      link.pending  = false
      link.rejected = true
      link.save
      # redirect_to request.referrer
    end

    def status_name
      status ? "Yes" : "No"
    end

    private

      def set_links
        @links = Link.where(coin_id: @coin.id).order("created_at DESC")
      end

      def partition_links
        @approved, @pending = @links.partition(&:accepted) 
      end

      def set_coin
        @coin = Coin.find(params[:coin_id])
      end

      def set_user
        @user = current_user
      end
      
      def accepted?
        @link.accepted
      end
      
      def link_params
        params.require(:link).permit(:url, :websitename, :accepted, :link_type, :exchange, :description)
      end

      # def find_link
      #   @link = Link.find(params[:id])
      # end
  end
end
