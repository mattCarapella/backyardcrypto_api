module Api::V1  
  class KeyPlayersController < ApiController
    before_action :set_coin
    before_action :set_key_player, except: [:index, :new, :create]
    # before_action :authenticate_user!, except: [:show, :index]
    # load_and_authorize_resource

    def index
      if params[:key_player].blank?  
        if params[:coin_id]
        	# Coin specific KeyPlayer archive (.../coins/bitcoin/key_players)
          @path = "coin"
          @pending_kp  = @coin.key_players.pending.order("title ASC")        
          @accepted_kp = @coin.key_players.active.order("title ASC")
          @rejected_kp = @coin.key_players.inactive.order("title ASC")
        else
        	# Whole site KeyPlayer archive (.../key_players)
          @path = "general"
          @pending_kp  = KeyPlayer.pending.order("title ASC")
          @accepted_kp = KeyPlayer.active.order("title ASC")         
          @rejected_kp = KeyPlayer.inactive.order("title ASC")  
        end  
        # Remove duplicates from @pending index if there is an approved kp with the same name
        if @accepted_kp.any? && @pending_kp.any?  
          @accepted_kps_titles = @accepted_kp.map { |t| t[:title] } 
          @pending_kp = @pending_kp.reject { |t| @accepted_kps_titles.include?(t[:title]) }
        end 
      else 
        if params[:coin_id]	
          # Specific KeyPlayer archive - Coin (.../coins/bitcoin/key_players?key_player=Decentralization)
          @kp_title = params[:key_player]
          @pending_kp  = @coin.key_players.pending.where("title=?", @kp_title).order("title ASC")
          @accepted_kp = @coin.key_players.active.where("title=?", @kp_title).order("title ASC")          
          @rejected_kp = @coin.key_players.inactive.where("title=?", @kp_title).order("title ASC")
        else
          # Specific KeyPlayer archive - Coin (.../coins/bitcoin/key_players?key_player=Decentralization)
          @kp_title = params[:key_player]
          @pending_kp  = KeyPlayer.pending.where("title=?", @kp_title).order("title ASC")
          @accepted_kp = KeyPlayer.active.where("title=?", @kp_title).order("title ASC")
          @rejected_kp = KeyPlayer.inactive.where("title=?", @kp_title).order("title ASC")
        end
      end   
      @active_count   = @accepted_kp.size if @accepted_kp
      @inactive_count = @rejected_kp.size if @rejected_kp
      @pending_count  = @pending_kp.size  if @pending_kp
    end

    def show
      @upvotes =         @key_player.get_upvotes.size
      @downvotes =       @key_player.get_downvotes.size
      @total_votes =     Float(@upvotes + @downvotes)
      @approval_rating = (@upvotes/@total_votes*100).round(2)
    end

    def new
      @key_player = current_user.key_players.build
    end

    def create
      #@key_player = current_user.key_players.build(key_player_params)
      @key_player = KeyPlayer.new(key_player_params)
      @key_player.coin = @coin
      if @key_player.save # && verify_recaptcha(model: @key_player)
        if params[:coin_id]
          render json: @key_player, status: :created
          #Notification.create(recipient: @coin.moderator, actor: current_user, action: "submitted", 
          #                    notifiable: @key_player)
        else
          render json: @key_player, status: :created
          #admin_user = User.where("admin=?", true).first
          #Notification.create(recipient: admin_user, actor: current_user, action: "submitted", 
          #                    notifiable: @key_player)
        end 
      else
        render json: @key_player.errors, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @key_player.update(key_player_params)
        render json: @key_player, status: :ok         
      else
        render json: @key_player.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @key_player.destroy
    end

    def activate
      # authorize! :update, @key_player
      if @key_player.valid? :activate # validates that there is only 1 accepted answer per KeyPlayer
        @key_player.active_status = 1
        @key_player.save!
        render json: @key_player, status: :ok
      else 
        render json: { error: 'can not activate' }, status: :unprocessable_entity
      end   
    end

    def deactivate
      # authorize! :update, @key_player
      unless @key_player.active_status = 2
        @key_player.active_status = 2
        @key_player.save!
      end
    end

    # def challenge
    #   old_key_player = @key_player.title
    #   @submissions = KeyPlayer.where(coin_id: @coin.id, title: old_key_player, accepted: false)
    # end

    private 

      def key_player_params
        params.require(:key_player).permit(:title, :caption, :content, :accepted, :pending, :rejected, :image,
          :image_caption, :slug, :upvotes, :downvotes, :approval_rating, :coin_id, :active_status)
      end

      def set_key_player
      	@key_player = KeyPlayer.friendly.find(params[:id]) 
      end

      def set_coin    
        @coin = Coin.friendly.find(params[:coin_id]) if params[:coin_id]
      end
  end
end
