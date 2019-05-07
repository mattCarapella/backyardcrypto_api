module Api::V1 
  class PostsController < ApiController
    before_action :set_coin, except: [:index]
  	#before_action :authenticate_user!, except: [:index, :show]
  	load_and_authorize_resource

    def index
  	  if params[:coin_id]
        @path = "coin"
  	  	@coin = Coin.find(params[:coin_id])
  	    if params[:sort] == "Popular"
          @sorted_by = "popular"
  	      @posts = Post.where(coin_id: @coin.id)
  	        .left_joins(:comments)
  	        .group(:id)
  	        .order('COUNT(comments.id) ASC')
  	    else
          @sorted_by = "created_at"
  	      @posts = Post.where(coin_id: @coin.id).order("created_at DESC")
  	    end
  	  else
        @path = "general" 
    		@posts = Post.where(coin_id: nil)
    	end
      @posts.each {
          |p|
          p.send('upvotes=', p.get_upvotes.size)
          p.send('downvotes=', p.get_downvotes.size)
      }
    end

    def show
      @post = Post.find(params[:id])
    	@coin = Coin.find(params[:coin_id]) if params[:coin_id]
    	if params[:comment]
    		@comments = @post.comments.where(id: params[:comment])
    	else
  	  	@comments = @post.comments.where(parent_id: nil)#.paginate(:page => params[:page], :per_page => 10)
  	  end
      @comments.each {
          |c|
          c.send('upvotes=', c.get_upvotes.size)
          c.send('downvotes=', c.get_downvotes.size)
      }
      @post.send('upvotes=', @post.get_upvotes.size)
      @post.send('downvotes=', @post.get_downvotes.size)
    end

    def new
      @post = current_user.posts.build
      @coin = Coin.find(params[:coin_id]) if params[:coin_id]
    end

  	def create
  		if params[:coin_id]
  			@coin = Coin.find(params[:coin_id])

  		  #@post = current_user.posts.build(post_params)
  		  #@post.user = current_user	  
        @post = Post.new

        @post.coin = @coin
        # @post.post_type = "coin"
  		else
  			# @post = current_user.posts.build(post_params)
  		  #  @post.user = current_user
        @post = Post.new
      
        # @post.post_type = "general"
  		end
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
  	end

    def edit
   		@coin = Coin.find(params[:coin_id]) if params[:coin_id]
    end

    def update
   		@coin = Coin.find(params[:coin_id]) if params[:coin_id]
      if @post.update(post_params)
        @post.edited = true
        @post.save
        if params[:coin_id]
  	      redirect_to coin_post_path(@coin.id, @post.id)
  			else
  				redirect_to post_path(@post.id)
  			end
      else
        redirect_to 'edit'
      end
    end

    def destroy
      @post.destroy
      if params[:coin_id]
  	    redirect_to coin_posts_path(@coin.id)
    	else
    		redirect_to posts_path
    	end
    end

    def delete
      @post = Post.find(params[:id] )
      @post.destroy
    end

    def getupvotes
      id = params[:post_id] ? params[:post_id] : params[:id]
      @post = Post.find(id)
      render json: {likes: @post.get_upvotes.size,dislikes: @post.get_downvotes.size}
    end

    def getdownvotes
      id = params[:post_id] ? params[:post_id] : params[:id]
      @post = Post.find(id)
      render json: {likes: @post.get_upvotes.size,dislikes: @post.get_downvotes.size}
    end

    def upvote
      id = params[:post_id] ? params[:post_id] : params[:id]
      @post = Post.find(id)
      @post.upvote_by current_user
      render json: {likes: @post.get_upvotes.size,dislikes: @post.get_downvotes.size}
    end

    def downvote
      id = params[:post_id] ? params[:post_id] : params[:id]
      @post = Post.find(id)
      @post.downvote_by current_user
      render json: {likes: @post.get_upvotes.size,dislikes: @post.get_downvotes.size}
    end

    private

  	  def set_coin
  	    @coin = Coin.friendly.find(params[:coin_id])
  	  end

  		def post_params
  			params.require(:post).permit(:content, :url, :title, :user_id, :picture, :post_type, :post_category)
  		end

  end
end