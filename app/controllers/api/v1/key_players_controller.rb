module Api::V1  
  class KeyPlayersController < ApiController
    before_action :set_coin
    before_action :set_key_player, except: [:index, :new, :create]
    #before_action :authenticate_user!, except: [:show, :index]
    load_and_authorize_resource

    def index
      if params[:key_player].blank?  
        if params[:coin_id]
        	# Coin specific kp page
          @path = "coin"
          @accepted_kp = KeyPlayer.where("coin_id=? AND accepted=?", @coin.id, true).order("title ASC")
          @pending_kp  = KeyPlayer.where("coin_id=? AND pending=?",  @coin.id, true).order("title ASC")
          @rejected_kp = KeyPlayer.where("coin_id=? AND rejected=?", @coin.id, true).order("title ASC")
        else
        	# Whole site kp page
          @path = "general"
          @accepted_kp = KeyPlayer.where("accepted=?", true).order("title ASC")
          @pending_kp  = KeyPlayer.where("pending=?",  true).order("title ASC")
          @rejected_kp = KeyPlayer.where("rejected=?", true).order("title ASC")   
        end  

        # Remove duplicates from @pending index if there is an approved kp with the same name
        if @accepted_kp.any? && @pending_kp.any?  
          @accepted_kps_titles = @accepted_kp.map { |t| t[:title] } 
          @pending_kp = @pending_kp.reject { |t| @accepted_kps_titles.include?(t[:title]) }
        end 
        
      else 
      	# Individual kp archive pages
        @kp_title = params[:key_player]
        @accepted_kp = KeyPlayer.where("title=? AND accepted=?", @kp_title, true).order("title ASC")
        @pending_kp  = KeyPlayer.where("title=? AND pending=?",  @kp_title, true).order("title ASC")
        @rejected_kp = KeyPlayer.where("title=? AND rejected=?", @kp_title, true).order("title ASC")
      end
      
      @active_count   = @accepted_kp.count if @accepted_kp
      @inactive_count = @rejected_kp.count if @rejected_kp
      @pending_count  = @pending_kp.count  if @pending_kp
    end

    def show
      @key_player =      KeyPlayer.friendly.find(params[:id])
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
      #if verify_recaptcha(model: @key_player) && @key_player.save
      if @key_player.save
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
    	@key_player = KeyPlayer.friendly.find(params[:id])
      if @key_player.update(key_player_params)
        if params[:coin_id]
          flash[:notice] = "Your edit has been recorded."
          redirect_to coin_key_player_path(@key_player.coin, @key_player)     
        else 
          flash[:notice] = "Your edit has been recorded."
          redirect_to key_players_path
        end
      else
        redirect_to 'edit'
      end
    end

    def destroy
      @key_player.destroy
      redirect_to request.referrer
      flash[:notice] = "Submission deleted."
    end

    def activate
      authorize! :update, @key_player
      key_player = KeyPlayer.find(params[:id])
      if key_player.valid? :activate 
        key_player.accepted = true
        key_player.pending  = false
        key_player.rejected = false
        key_player.save
        redirect_to request.referrer
      else 
        flash[:notice] = "Sorry. There can only be one approved item."
        redirect_to request.referrer
      end   
    end

    def deactivate
      authorize! :update, @key_player
      key_player = KeyPlayer.find(params[:id])   
      key_player.accepted = false
      key_player.pending = false
      key_player.rejected = true
      key_player.save
      redirect_to request.referrer
    end

    def challenge

      old_key_player = @key_player.title
      @submissions = KeyPlayer.where(coin_id: @coin.id, title: old_key_player, accepted: false)
    end

    private 

      def key_player_params
        params.require(:key_player).permit(:title, :caption, :content, :accepted, :pending, :rejected, :image,
          :image_caption, :slug, :upvotes, :downvotes, :approval_rating, :coin_id)
      end

      def set_key_player
      	@key_player = KeyPlayer.friendly.find(params[:id]) 
      end

      def set_coin    
        @coin = Coin.friendly.find(params[:coin_id]) if params[:coin_id]
      end
  end
end
