module Api::V1   
  class FlagsController < ApiController
    before_action :set_flag, only: [:destroy ]
    #before_action :authenticate_user!

    def index
      if params[:question_id]  
        @coin = Coin.friendly.find(params[:coin_id])
        @question = @coin.questions.find(params[:question_id])
        @flags = @question.flags.all
      elsif params[:post_id]
        @coin = Coin.friendly.find(params[:coin_id]) if params[:coin_id]
        @post = Post.find(params[:post_id])
        @flags = @post.flags.all
      end
    end

    def new
      if params[:question_id]  
        @flag = Flag.new
        @coin = Coin.friendly.find(params[:coin_id])
        @question = Question.find(params[:question_id])
      elsif params[:post_id]
        @flag = Flag.new
        @coin = Coin.friendly.find(params[:coin_id]) if params[:coin_id]
        @post = Post.find(params[:post_id])
      end
    end

    def create 
      if params[:question_id] 
        @coin = Coin.friendly.find(params[:coin_id])
        @question = @coin.questions.find(params[:question_id])
        @flag = @question.flags.new(flag_params)
        @flag.user = current_user
        if @flag.save!
          render json: @flag, status: :created
          #Notification.create(recipient: @coin.moderator, actor: current_user, action: "flagged", notifiable: @question)
        else
          render json: {@flag.errors}, status: :unprocessable_entity
        end

      elsif params[:post_id]
        if params[:coin_id]
          @post = Post.find(params[:post_id])
          @coin = @post.coin
          @flag = @post.flags.new(flag_params)
          @flag.user = current_user
          @flag.coin = @coin
          if @flag.save!
            #Notification.create(recipient: @coin.moderator, actor: current_user, action: "flagged", notifiable: @post)
            render json: @flag, status: :created
          else
            render json: {@flag.errors}, status: :unprocessable_entity
          end
        else
          @post = Post.find(params[:post_id])
          @flag = @post.flags.new(flag_params)
          @flag.user = current_user
          if @flag.save!
            #rec = User.find(1) # admin
            #Notification.create(recipient: rec, actor: current_user, action: "flagged", notifiable: @post)
            render json: @flag, status: :created
          else
            render json: {@flag.errors}, status: :unprocessable_entity
          end
        end
      end
    end

    def destroy
      @flag.destroy
    end

    private 

      def flag_params 
        params.require(:flag).permit(:reason_for_flag, :post_id, :coin_id)
      end 

      def set_flag 
        @flag = Flag.find(params[:id])
      end 

      def set_question 
        @question = @coin.questions.find(params[:question_id])
      end 

      def set_coin 
        @coin = Coin.friendly.find(params[:coin_id])
      end 
  end
end
