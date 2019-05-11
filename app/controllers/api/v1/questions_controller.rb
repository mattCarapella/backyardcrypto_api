 module Api::V1  
  class QuestionsController < ApiController
    before_action :find_coin #, except: [:editor_images, :geteditor_images]
    before_action :find_ques_num, only: [:index]  
    # before_action :find_user
    # before_action :ensure_url_params, only:[:new]
    # before_action :find_top_picture, only: [:show]
    # skip_before_action :verify_authenticity_token, :only => [:editor_images]
    # before_action :authenticate_user!, except: :show
    # load_and_authorize_resource

    def index
      @sort_by = params[:sort_by] ? params[:sort_by] : 'approval'
      
      if params[:ques_num].blank?
        p "***** PARAMS[:ID] NOT FOUND"
        @questions = Question.where(coin_id: @coin.id).order("created_at DESC")
      
      else 
        p "PARAMS[:ID] FOUND *****"
        if params[:id]
          @question = Question.find(params[:id])
          @topic = @question.open_topic
          @questions = Question.where(coin_id: @coin.id, ques_num: @num, open_topic: @topic)
        else
          @questions = Question.where(ques_num: @num, coin_id: @coin.id)
        end
        @inactive_count = @questions.where('ques_num=? and rejected=?', params[:ques_num], true).count
        @pending_count = @questions.where('ques_num=? and pending=?', params[:ques_num], true).count
        @accepted = @questions.where("ques_num=? AND accepted=?", params[:ques_num], true)
        @pending = Question.where("coin_id=? AND ques_num=? AND pending=?", @coin.id, params[:ques_num], true).order("created_at ASC")
        if @sort_by == 'approval'
          @rejected = @questions.where("ques_num=? AND rejected=?", params[:ques_num], true).order("approval_rating DESC")
        elsif @sort_by == 'created_at'
          @rejected = @questions.where("ques_num=? AND rejected=?", params[:ques_num], true).order("created_at ASC")
        end
        @included_topics = @coin.questions.where("ques_num=? AND accepted=?", 5, true).map(&:open_topic)
        @open_topics = @coin.questions.where('ques_num=? and pending=?', 5, true).select { |a| @included_topics.exclude? (a.open_topic)}
        @open_topic_count = @coin.questions.where('ques_num=? and pending=?', 5, true).select { |a| @included_topics.exclude? (a.open_topic)}.count
      end
    end

    def show
      @question = Question.find(params[:id])
      @upvotes = @question.get_upvotes.size
      @downvotes = @question.get_downvotes.size
      @total_votes = Float(@upvotes + @downvotes)
      @approval_rating = (@upvotes/@total_votes*100).round(2)
      # @comments = @question.comments.where(parent_id: nil)
      # @comments.each {
      #     |c|
      #     c.send('upvotes=', c.get_upvotes.size)
      #     c.send('downvotes=', c.get_downvotes.size)
      # }
      # @main_page_images = @question.question_images.where("accepted=?", true).first(8)
      # @citations = @question.citations.all.order("source_num ASC")
      @question.send('upvotes=', @question.get_upvotes.size)
      @question.send('downvotes=', @question.get_downvotes.size)
    end

   #  def discussion
   #  	@question = Question.find(params[:id])
   #  	if params[:comment]
   #  		@comments = @question.comments.where(id: params[:comment])
   #  	else
  	#   	@comments = @question.comments.where(parent_id: nil).paginate(:page => params[:page], :per_page => 10)
  	#   end
   #      @comments.each {
   #          |c|
   #          c.send('upvotes=', c.get_upvotes.size)
   #          c.send('downvotes=', c.get_downvotes.size)
   #      }
   #  end

    def new
      #@question = current_user.questions.build
      @question = Question.new
    end

    def create
      #@question = current_user.questions.build(question_params)
      @question = Question.new(question_params)
      @question.coin = @coin
      if @question.save
        render json: @question, status: :created
      else
        render json: @question.errors, status: :unprocessable_entity
      end

   #   if verify_recaptcha(model: @question) && @question.save
   #      Notification.create(recipient: @coin.moderator, actor: current_user, action: "submitted",
   #                              notifiable: @question)
   #      flash[:notice] = "Your submission has been accepted and will be reviewed by a moderator."
   #      redirect_to coin_path(@coin)
   #   else
   #      flash[:notice] = "reCaptcha verification unsuccessful. Please try again."
   #     render 'new'
   #   end
    end

   #  def update
   #    if @question.update(question_params)
   #      if @question.ques_num == 2 or @question.ques_num ==3
   #        flash[:notice] = "Your edit has been recorded."
   #        redirect_to coin_question_path(@coin, @question.id)
   #      else
   #        flash[:notice] = "Your edit has been recorded."
   #        redirect_to coin_path(@coin)
   #      end
   #    else
   #      redirect_to 'edit'
   #    end
   #  end

   #  def destroy
   #    @question.destroy
   #    redirect_to @coin
   #    flash[:notice] = "Submission deleted."
   #  end

   #  def geteditor_images
   #    @host = request.protocol+request.host_with_port
   #    @editor_images = current_user.editor_files
   #    @CKEditorFuncNum = params[:CKEditorFuncNum]
   #  end

   #  def editor_images
   #    file = current_user.editor_files.build(file: params[:upload])
   #    if file.save
   #      host = request.protocol+request.host_with_port
   #      render html: "<h6 > Link: #{host}#{file.file.url} </h6>".html_safe
   #    else
   #      render plain: "Unable to send image. #{file.errors.full_messages.first}"
   #    end
   #  end

   #  def pending
   #    sort_by = 'created_at'
   #    @already_included = Question.where("coin_id=? AND ques_num=? AND accepted=?", @coin.id, params[:ques_num], true).map(&:term)
   #    @inactive = Question.where('coin_id=? AND ques_num=? and rejected=?', @coin.id, params[:ques_num], true).select { |a| @already_included.exclude? (a.term) }
   #    @inactive_count = @inactive.count
   #    @pending = Question.where('coin_id=? AND ques_num=? AND pending=?', @coin.id, params[:ques_num], true).select { |a| @already_included.exclude? (a.term) }
   #    @pending_count = @pending.count
   #    logger.info(@questions.to_json)
   #  end

   #  def pending_topics
  	# 	@question
   #    authorize! :update, @question
  	# 	@already_included_topics = Question.where("ques_num=? AND accepted=? AND coin_id=?", 5, true, @coin.id).map(&:open_topic)
  	# 	@pending = Question.where("ques_num=? AND pending=? AND coin_id=?", 5, true, @coin.id).select { |a| @already_included_topics.exclude? (a.open_topic) }
  	# 	logger.info(@questions.to_json)
   #  end

   #  def rejected
   #    @questions = Question.where(coin_id: @coin.id).order("created_at DESC")
   #    @rejected = @questions.select { |question| question.rejected == true }
   #    authorize! :update, @question
   #    logger.info(@questions.to_json)
   #  end

    def challenge
      #:authenticate_user!
    	 if @question.ques_num == 5
  			old_topic = @question.open_topic
  			@submissions = Question.where(coin_id: @coin.id, ques_num: 5, open_topic: old_topic, accepted: false)
    	end
    end

   #  def archive
   #    @archived = Question.where("coin_id=?", @coin.id).only_deleted.order("created_at ASC")
   #  end

    def activate
      #authorize! :update, @question
      question = Question.find(params[:id])
      if question.valid? :activate
        if !question.accepted?
          question.accepted = true
          question.pending  = false
          question.rejected = false
          question.save!

          if question.ques_num == 1

          elsif question.ques_num == 6
            
          elsif question.ques_num == 7

          elsif question.ques_num == 8

          elsif question.ques_num == 9

          end

        end
      #else
        #flash[:notice] = "Sorry. There can only be one approved item."
      end
    end

    def deactivate
      #authorize! :update, @question
      question = Question.find(params[:id])
      if question.accepted?
        question.accepted = false
        question.pending  = false
        question.rejected = true
      end
      question.save
    end

   #  def upvote
   #    @question = Question.find(params[:id] )
   #    @question.upvote_by current_user
   #    upvotes = @question.get_upvotes.size
   #    downvotes = @question.get_downvotes.size
   #    total_votes = Float(upvotes + downvotes)
   #    @question.update(approval_rating: (upvotes/total_votes).round(4))
   #    redirect_to request.referrer
   #  end

   #  def downvote
   #    @question = Question.find(params[:id] )
   #    @question.downvote_by current_user
   #    upvotes = @question.get_upvotes.size
   #    downvotes = @question.get_downvotes.size
   #    total_votes = Float(upvotes + downvotes)
   #    @question.update(approval_rating: (upvotes/total_votes).round(4))
   #    redirect_to request.referrer
   #  end

   #  def get_approval_rating
   #    upvotes = self.get_upvotes.size
   #    downvotes = self.get_downvotes.size
   #    total_votes = Float(upvotes + downvotes)
   #    @approval_rating = (upvotes+up_add/total_votes+down_add*100).round(2)
   #  end

   #  def flag
   #    @question.update(flagged: true)
   #    Notification.create(recipient: @question.coin.moderator, actor: current_user, action: "flagged",
   #                              notifiable: @question)
   #    redirect_to [@question.coin, @question]
   #  end

    
    private

      def question_params
        params.require(:question).permit(:content, :ques_num, :coin_id, :accepted, :term, :description, :caption, :image, :image_caption, :open_topic, :slug, :flagged)
      end

    	def find_ques_num
    		@num = params.fetch(:ques_num) if params[:ques_num]
    	end

      def find_coin
        @coin = Coin.friendly.find(params[:coin_id])
      end

      def find_user
        @user = current_user
      end
     
      def accepted?
        @question.accepted
      end

   #    def find_top_picture
   #      @question = Question.find(params[:id])
   #      @primary_pics = QuestionImage.where("question_id=? AND top_pic=?", @question.id, true)
   #    end

   #    def ensure_url_params
   #      if params[:ques_num].present?
   #        logger.info("THis is ensure_url_params")
   #        return
   #      else
   #        render file: "#{Rails.root}/public/404", status: :not_found
   #      end
   #    end

 end
 
end
