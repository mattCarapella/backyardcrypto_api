module Api::V1 
  class TermsController < ApiController  
    before_action :authenticate_user!, except: [:index]
    before_action :set_coin 
    #load_and_authorize_resource

    def index
      
      if params[:term].blank?  
      

      # All terms archive
        if params[:coin_id]
          # Coin specific terminology index pages
          @path = "coin"
          @accepted = Term.where("coin_id=? AND accepted=?", @coin.id, true).order("title ASC")        
          @pending  = Term.where("coin_id=? AND pending=?", @coin.id, true).order("title ASC")
          @pending2 = []
          @rejected = Term.where("coin_id=? AND rejected=?", @coin.id, true).order("title ASC")
        else
          # Whole site terminology index page
          @path = "general"
          @accepted = Term.where("accepted=?", true).order("title ASC")
          @pending  = Term.pending.order("title ASC")
          @rejected = Term.where("rejected=?", true).order("title ASC")      
        end  

        # Remove duplicates from @pending index if there is an approved term with the same name
        if @accepted.any? && @pending.any?  
          accepted_terms_titles = @accepted.map { |t| t[:title] } 
          @pending = @pending.reject { |t| accepted_terms_titles.include?(t[:title]) }
        end 
      
      else 
      # Individual term index pages
        @term_title = params[:term]
        @accepted   = Term.where("title=? AND accepted=?", @term_title, true).order("title ASC")
        @pending    = Term.where("title=? AND pending=?", @term_title, true).order("title ASC")
        @rejected   = Term.where("title=? AND rejected=?", @term_title, true).order("title ASC")
      end

      @active_count   = @accepted.count if @accepted
      @inactive_count = @rejected.count if @rejected
      @pending_count  = @pending.count if @pending
    end

    def show
      @term = Term.friendly.find(params[:id])
      @upvotes = @term.get_upvotes.size
      @downvotes = @term.get_downvotes.size
      @total_votes = Float(@upvotes + @downvotes)
      @approval_rating = (@upvotes/@total_votes*100).round(2)
    end

    def new
      @term = current_user.terms.build
    end

    def create
      #@term = current_user.terms.build(term_params)
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
      @term = Term.friendly.find(params[:id])
      if @term.update(term_params)
        # flash[:notice] = "Your edit has been recorded."
        if params[:coin_id]
          @coin = Coin.friendly.find(params[:coin_id]) 
          # redirect_to coin_term_path(@term.coin, @term)     
        else 
          # redirect_to terms_path
        end
      else
        redirect_to 'edit'
      end
    end

    def destroy
      # @term = Term.friendly.find(params[:id])
      @term = Term.find(params[:id])
      @term.destroy
      # redirect_to request.referrer
      # flash[:notice] = "Submission deleted."
    end

    def activate
      # authorize! :update, @term
      term = Term.find(params[:id])
      if term.valid? :activate 
        term.accepted = true
        term.pending = false
        term.rejected = false
        term.save
        # redirect_to request.referrer
      else 
        # flash[:notice] = "Sorry. There can only be one approved item."
        # redirect_to request.referrer
      end   
    end

    def deactivate
      # authorize! :update, @term
      term = Term.find(params[:id])   
      term.accepted = false
      term.pending = false
      term.rejected = true
      term.save!
      # redirect_to request.referrer
    end

    def challenge 
      old_term = @term.title
      @submissions = Term.where(coin_id: @coin.id, title: old_term, accepted: false)
    end
    
    private 

      def term_params
        params.require(:term).permit(:title, :caption, :content, :accepted, :pending, :rejected, :image,
          :image_caption, :slug, :upvotes, :downvotes, :approval_rating, :coin_id)
      end

      def set_coin    
        @coin = Coin.friendly.find(params[:coin_id]) if params[:coin_id]
      end

  end
end
