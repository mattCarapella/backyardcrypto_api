module Api::V1   
  class FlagsController < ApiController
    before_action :set_flag, only: [:destroy ]
    #before_action :authenticate_user!

    def index
      if params[:question_id]  
        @coin = Coin.find(params[:coin_id])
        @question = @coin.questions.find(params[:question_id])
        @flags = @question.flags.all
      elsif params[:post_id]
        @coin = Coin.find(params[:coin_id]) if params[:coin_id]
        @post = Post.find(params[:post_id])
        @flags = @post.flags.all
      end
    end

    def new
      if params[:question_id]  
        @flag = Flag.new
        @coin = Coin.find(params[:coin_id])
        @question = Question.find(params[:question_id])
      elsif params[:post_id]
        @flag = Flag.new
        @coin = Coin.find(params[:coin_id]) if params[:coin_id]
        @post = Post.find(params[:post_id])
      end
    end

    def create 
      if params[:question_id] 
        @coin = Coin.find(params[:coin_id])
        @question = @coin.questions.find(params[:question_id])
        @flag = @question.flags.new(flag_params)
        @flag.user = current_user
        if @flag.save!
          #Notification.create(recipient: @coin.moderator, actor: current_user, action: "flagged", 
                                notifiable: @question)
          #flash[:notice] = "Your submission has been accepted and will be reviewed by a moderator."
          #redirect_to coin_question_path(@coin, @question)
        else
          render 'new'
        end

      elsif params[:post_id]
        if params[:coin_id]
          @post = Post.find(params[:post_id])
          @coin = @post.coin
          @flag = @post.flags.new(flag_params)
          @flag.user = current_user
          @flag.coin = @coin
          if @flag.save!
            #Notification.create(recipient: @coin.moderator, actor: current_user, action: "flagged", 
                                notifiable: @post)
            #flash[:notice] = "Your submission has been accepted and will be reviewed by a moderator."
            #redirect_to coin_post_path(@coin, @post)
          else
            render 'new'
          end
        else
          @post = Post.find(params[:post_id])
          @flag = @post.flags.new(flag_params)
          @flag.user = current_user
          if @flag.save!
            #rec = User.find(1) # admin
            #Notification.create(recipient: rec, actor: current_user, action: "flagged", 
            #                    notifiable: @post)
            #flash[:notice] = "Your submission has been accepted and will be reviewed by a moderator."
            #redirect_to post_path(@post)
          else
            render 'new'
          end
        end
      end
    end

    def destroy
      @flag.destroy 
      if params[:question_id]
        redirect_to coin_question_path(@flag.question.coin, @flag.question)
      elsif params[:post_id]
        if params[:coin_id]
          #redirect_to coin_post_path(@flag.post.coin, @flag.post)
        else
          #redirect_to post_path(@flag.post)
        end
      end
    end

    private 

      def set_flag 
        @flag = Flag.find(params[:id])
      end 

      def set_question 
        @question = @coin.questions.find(params[:question_id])
      end 

      def set_coin 
        @coin = Coin.find(params[:coin_id])
      end 

      def flag_params 
        params.require(:flag).permit(:reason_for_flag, :post_id, :coin_id)
      end 

  end
end
