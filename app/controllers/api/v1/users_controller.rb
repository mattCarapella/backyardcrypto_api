module Api::V1  
  class UsersController < ApiController
   
    #respond_to :json

    def create
      @user = User.new(user_params)
      if @user.save
        #render json: user, status: 201, location: [:api, user]
        render :create, status: :created, locals: { user: @user }
      else
        #render json: { errors: user.errors }, status: 422
      end
    end

    def index
      @users = User.all
    end

    def show
      @user = User.find(params[:id])
      @user_questions = @user.questions 
      @user_terms = @user.terms 
      @user_keyplayers = @user.key_players
      @user_links = @user.links
      @user_events = @user.events
      #@user_favorites = @user.favorites
    end
   
    private 

      def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation, :fname, :lname, :newsletter)
      end

  	# def index
  	# 	@users = User.order(params[:id])
  	# end

  	# def show
			# @user = User.find(params[:id])
			# @upvoted_questions = @user.get_up_voted Question
			# @downvoted_questions = @user.get_down_voted Question
	  #   @upvoted_events = @user.get_up_voted Event
	  #   @downvoted_events = @user.get_down_voted Event
   #    # render json: @user, status: 201
  	# end
    

  
    # def update
    #   user = User.find(params[:id])
    #   if user.update(user_params)
    #     render json: user, status: 200, location: [:api, user]
    #   else
    #     render json: { errors: user.errors }, status: 422
    #   end
    # end

    # def destroy
    #   user = User.find(params[:id])
    #   user.destroy
    #   head 204
    # end
  end 
end