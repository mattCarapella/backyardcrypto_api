 module Api::V1  
  class QuestionsController < ApiController
    before_action :find_coin #, except: [:editor_images, :geteditor_images]
    before_action :find_ques_num, only: [:index]
    # before_action :ensure_url_params, only:[:new]
    # before_action :find_top_picture, only: [:show]
    # skip_before_action :verify_authenticity_token, :only => [:editor_images]
    # before_action :authenticate_user!, except: :show
    # load_and_authorize_resource

    def index
      @sort_by = params[:sort_by] ? params[:sort_by] : 'approval'    
      if params[:ques_num].blank?
        # Archive for all coin questions (.../coins/bitcoin/questions)
        @pending =  @coin.questions.pending
        @accepted = @coin.questions.active
        @inactive = @coin.questions.inactive
      else 
        if params[:id] && params[:ques_num] == '5'
          # Archive for open topic questions (.../coins/bitcoin/questions?id=29&ques_num=5)
          num = params[:ques_num]
          question = Question.find(params[:id])
          topic = question.open_topic
          @pending  = @coin.questions.open_topic.pending.where("open_topic=?", topic)
          @accepted = @coin.questions.open_topic.active.where("open_topic=?", topic)
          @rejected = @coin.questions.open_topic.inactive.where("open_topic=?", topic)
        else
          # Archive for specific questions (.../coins/bitcoin/questions?ques_num=2)
          num = params[:ques_num]
          @pending  = @coin.questions.pending.where("ques_num=?", num)
          @accepted = @coin.questions.active.where("ques_num=?", num)
          @rejected = @coin.questions.inactive.where("ques_num=?", num)
        end
        if params[:ques_num] == '5' 
          @included_topics =  @coin.questions.open_topic.active.map(&:open_topic)
          @open_topics =      @coin.questions.open_topic.pending.select { |a| @included_topics.exclude? (a.open_topic)}
          @open_topic_count = @open_topics.size
        end
      end
    end

    def show
      @question        = Question.find(params[:id])
      @upvotes         = @question.get_upvotes.size
      @downvotes       = @question.get_downvotes.size
      @total_votes     = Float(@upvotes + @downvotes)
      @approval_rating = (@upvotes/@total_votes*100).round(2)
      @comments        = @question.comments.all
      @comments        = @question.comments.where(parent_id: nil)

      @comments.each do |c|
        c.send('upvotes=', c.get_upvotes.size)
        c.send('downvotes=', c.get_downvotes.size)
      end

      # @main_page_images = @question.question_images.where("accepted=?", true).first(8)
      @citations = @question.citations.all
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
      if @question.save # && verify_recaptcha(model: @question)
        # Notification.create(recipient: @coin.moderator, actor: current_user, action: "submitted", notifiable: @question)
        render json: @question, status: :created
      else
        render json: @question.errors, status: :unprocessable_entity
      end
    end

    def update
      @question = Question.find(params[:id])
      if @question.update(question_params)
        render json: @question, status: :ok   
      else
        render json: @question.errors, status: :unprocessable_entity   
      end
    end

    def destroy
      @question = Question.find(params[:id])
      @question.destroy
    end

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

    def challenge
      #:authenticate_user!
      @question = Question.find(params[:id])
    	if @question.ques_num == 5
  			old_topic = @question.open_topic
  			@submissions = @coin.questions.where("ques_num=? AND open_topic=? AND active_status=?", 5, old_topic, 2)
    	end
    end

    def activate
      #authorize! :update, @question
      question = Question.find(params[:id])
      if question.valid? :activate
        if question.active_status == 0 or question.active_status == 2
          question.active_status = 1
          question.save!
        end
      end
    end

    def deactivate
      #authorize! :update, @question
      question = Question.find(params[:id])
      if question.active_status == 0 or question.active_status == 1
        question.active_status = 2
        question.save!
      end   
    end

    def upvote
      @question = Question.find(params[:id] )
      @question.upvote_by current_user if current_user
      upvotes = @question.get_upvotes.size
      downvotes = @question.get_downvotes.size
      total_votes = Float(upvotes + downvotes)
      @question.update(approval_rating: (upvotes/total_votes).round(4))
    end

    def downvote
      @question = Question.find(params[:id] )
      @question.downvote_by current_user if current_user
      upvotes = @question.get_upvotes.size
      downvotes = @question.get_downvotes.size
      total_votes = Float(upvotes + downvotes)
      @question.update(approval_rating: (upvotes/total_votes).round(4))
    end

    # def flag
    #   @question.update(flagged: true)
    #   Notification.create(recipient: @question.coin.moderator, actor: current_user, action: "flagged", notifiable: @question)
    # end

    
    private

      def question_params
        params.require(:question).permit(:content, :ques_num, :coin_id, :accepted, :term, :description, :caption, 
            :image, :image_caption, :open_topic, :slug, :flagged, :active_status)
      end

    	def find_ques_num
    		@num = params.fetch(:ques_num) if params[:ques_num]
    	end

      def find_coin
        @coin = Coin.friendly.find(params[:coin_id])
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
