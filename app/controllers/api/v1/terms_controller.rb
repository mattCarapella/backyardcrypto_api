module Api::V1 
  class TermsController < ApiController  
    before_action :set_term, except: [:index, :create, :new]
    before_action :set_coin 
    before_action :authenticate_user!, except: [:index]
    load_and_authorize_resource

    def index      
      if params[:term].blank?   
        if params[:coin_id]
          # Coin specific Term archive (.../coins/bitcoin/terms)
          @path = "coin"
          @pending  = @coin.terms.where("active_status=?", 0).order("title ASC")        
          @accepted = @coin.terms.where("active_status=?", 1).order("title ASC")
          @rejected = @coin.terms.where("active_status=?", 2).order("title ASC")        
        else
          # Whole site Term archive (.../terms)
          @path = "general"
          @pending  = Term.where("active_status=?", 0).order("title ASC")        
          @accepted = Term.where("active_status=?", 1).order("title ASC")
          @rejected = Term.where("active_status=?", 2).order("title ASC")    
        end  
        if @accepted.any? && @pending.any?  
          # Remove duplicates from @pending index if there is an approved term with the same name
          accepted_terms_titles = @accepted.map { |t| t[:title] } 
          @pending = @pending.reject { |t| accepted_terms_titles.include?(t[:title]) }
        end 
      else 
        if params[:coin_id]  
          # Specific Term archive - Coin (.../coins/bitcoin/terms?term=Decentralization)
          @term_title = params[:term]
          @pending    = @coin.terms.where("title=? AND active_status=?", @term_title, 0).order("title ASC")
          @accepted   = @coin.terms.where("title=? AND active_status=?", @term_title, 1).order("title ASC")        
          @rejected   = @coin.terms.where("title=? AND active_status=?", @term_title, 2).order("title ASC")
        else
          # Specific Term archive - General (.../terms?term=Decentralization)
          @term_title = params[:term]
          @pending    = Term.where("title=? AND active_status=?", @term_title, 0).order("title ASC")
          @accepted   = Term.where("title=? AND active_status=?", @term_title, 1).order("title ASC")        
          @rejected   = Term.where("title=? AND active_status=?", @term_title, 2).order("title ASC") 
        end
      end
      @active_count   = @accepted.length if @accepted
      @inactive_count = @rejected.length if @rejected
      @pending_count  = @pending.length  if @pending
    end

    def show
      @upvotes = @term.get_upvotes.size
      @downvotes = @term.get_downvotes.size
      @total_votes = Float(@upvotes + @downvotes)
      @approval_rating = (@upvotes/@total_votes*100).round(2)
    end

    def new
      @term = current_user.terms.build
    end

    def create
      # @term = current_user.terms.build(term_params)
      @term = Term.new(term_params)
      @term.coin = @coin

      if @term.save # && verify_recaptcha(model: @term)
        if params[:coin_id]
          render json: @term, status: :created
          # Notification.create(recipient: @coin.moderator, actor: current_user, action: "submitted", 
          #                     notifiable: @term)
        else
          render json: @term, status: :created
          # admin_user = User.where("admin=?", true).first
          # Notification.create(recipient: admin_user, actor: current_user, action: "submitted", 
          #                     notifiable: @term)
        end 
      else
        render json: @term.errors, status: :unprocessable_entity
      end
    end

    def edit

    end

    def update
      # authorize! :update, @term
      if @term.update(term_params)        
        render json: @term, status: :ok       
      else
        render json: @term.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @term.destroy
    end

    def activate
      # authorize! :update, @term
      if @term.valid? :activate 
        @term.active_status = 1
        @term.save
        render json: @term, status: :ok  
      else 
        render json: @term.errors, status: :unprocessable_entity  
      end   
    end

    def deactivate
      # authorize! :update, @term
      @term.active_status = 2
      @term.save!
    end

    def challenge 
      old_term = @term.title
      @submissions = Term.where(coin_id: @coin.id, title: old_term, accepted: false)
    end
    
    private 

      def term_params
        params.require(:term).permit(:title, :caption, :content, :accepted, :pending, :rejected, :image,
          :image_caption, :slug, :upvotes, :downvotes, :approval_rating, :coin_id, :active_status)
      end

      def set_coin    
        @coin = Coin.friendly.find(params[:coin_id]) if params[:coin_id]
      end

  end
end
