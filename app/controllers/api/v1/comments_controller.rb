module Api::V1   
  class CommentsController < ApiController
    #before_action :authenticate_user!
  	load_and_authorize_resource

    def index
      @comments = @commentable.comments.all
      render json: {likes: @comments}
      # @comments.each {
      #     |c|
      #     c.send('upvotes=', c.get_upvotes.size)
      #     c.send('downvotes=', c.get_downvotes.size)
      # }
    end

    def create
      @comment = @commentable.comments.new(comment_params)
      @comment.user = current_user

      if @comment.parent.present?
      	recipient = @comment.parent.user
      else
      	recipient = @comment.commentable.user
      end

      if params[:coin_id]
        @comment.coin = Coin.find(params[:coin_id])
      end

      if @comment.save
      	if @comment.commentable and @comment.parent.present?
  				Notification.create(recipient: @comment.parent.user, actor: current_user, action: "replied",
  														notifiable: @comment)
  			end
          render json: {comment: @comment}
      	# respond_to do |format|
      	# 	if params[:coin_id]
  	    # 		format.html { redirect_to [@commentable.coin, @commentable] }
    		# 	else
    		# 		format.html { redirect_to @commentable }
    		# 	end
      	# 	format.js {}
      	# end
      else
      	if params[:coin_id]
      		redirect_to [@commentable.coin, @commentable], alert: "An error occured while posting your comment."
      	else
      		redirect_to @commentable, alert: "An error occured while posting your comment."
      	end
      end
    end

    def update
    	@comment = Comment.find(params[:id])
      if @comment.update(comment_params)
        @comment.edited = true
        @comment.save
      end

       render json: {comment: @comment}
    end

    def destroy
  #  	@comment = Comment.find(params[:id])
  #   @comment.destroy
  #   redirect_to request.referrer
  		@comment = @commentable.comments.find(params[:id])
  		@comment.deleted = true
  		@comment.save
  		# redirect_to request.referrer
    end

    def upvote
      @comment = @commentable.comments.find(params[:id])
      @comment.upvote_by current_user
      render json: {likes: @comment.get_upvotes.size,dislikes: @comment.get_downvotes.size}
    end

    def downvote
      @comment = @commentable.comments.find(params[:id])
      @comment.downvote_by current_user
      render json: {likes: @comment.get_upvotes.size,dislikes: @comment.get_downvotes.size}
    end

    private

      def set_coin
        @coin = Coin.find(params[:coin_id])
      end

      def comment_params
      	params.require(:comment).permit(:body, :parent_id)
      end

  end
end
