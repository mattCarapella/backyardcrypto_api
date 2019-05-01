module Api::V1 
  class EventsController < ApiController
    before_action :set_coin
    before_action :set_event, only: [:show, :update, :destroy]
    #before_action :authenticate_user!, except: [:calendar, :index]
    load_and_authorize_resource

    def index
  		#@events = Event.where(coin_id: @coin.id).order("created_at DESC")
      @events = @coin.events.order(:start_time)
      
      @events.each {
        |e|
        e.send('upvotes=', e.get_upvotes.size)
        e.send('downvotes=', e.get_downvotes.size)
      }

      @coin_events = @coin.events.order(:date)
      @today = Date.current  
      @accepted = Event.active_events.where("coin_id=?", @coin.id)
      @pending_events = Event.pending_events.where("coin_id=?", @coin.id)
      @rejected = Event.inactive_events.where("coin_id=?", @coin.id)
      @upcoming_events = @accepted.where('start_time > ?', @today)
      @past_events = @accepted.where('start_time < ?', @today)
    end

    def calendar
      @coin = Coin.find(params[:coin_id])
      @events = @coin.events.where('accepted=? AND start_time > ?', true, Date.today)
    end

    def show
     @nearby_events = @event.nearbys
    end

    def new
      @event = current_user.events.build
    end

  	def create
  	  #@event = current_user.events.build(event_params)
  	  @event = Event.new(event_params)
      @event.coin = @coin
      if @event.save
        @event.geocode
        @event.save!
        render json: @event, status: :created
  	  else
        render json: @event.errors, status: :unprocessable_entity
  	  end
  	end

    def edit
    end

    def update
      if @event.update(event_params)
        #redirect_to coin_event_path(@coin, @event.id)
        @updated = true
      else
        #redirect_to 'edit'
        @updated = false
      end
    end

    def destroy
      @event.destroy
      redirect_to coin_events_path(@coin.id)
    end

    def getupvotes
      @event = Event.find(params[:id] )
      render json: {likes: @event.get_upvotes.size,dislikes: @event.get_downvotes.size}
    end

    def getdownvotes
      @event = Event.find(params[:id] )
      render json: {likes: @event.get_upvotes.size,dislikes: @event.get_downvotes.size}
    end

    def upvote
    	@event = Event.find(params[:id] )
    	@event.upvote_by current_user
      render json: {likes: @event.get_upvotes.size,dislikes: @event.get_downvotes.size}
    end

    def downvote
    	@event = Event.find(params[:id] )
    	@event.downvote_by current_user
      render json: {likes: @event.get_upvotes.size,dislikes: @event.get_downvotes.size}
    end

    def activate
      #authorize! :update, @event
      event = Event.find(params[:id])
      event.accepted = true
      event.pending = false
      event.rejected = false
      event.save
      #redirect_to request.referrer
    end

    def deactivate
      #authorize! :update, @event
      event = Event.find(params[:id])    
      event.accepted = false
      event.pending = false
      event.rejected = true
      event.save
      #redirect_to request.referrer
    end


    private

      def event_params
        params.require(:event).permit(:content, :link, :date, :start_time, :end_time, :time, :start_date, :end_date,
          :venue, :street_address, :city, :state, :country, :zipcode, :description, :accepted,
          :latitude, :longitude, :upvotes, :downvotes)
      end
      
      def set_event
        @event = Event.find(params[:id])
      end

      def set_coin
        @coin = Coin.find(params[:coin_id])
      end

      def get_upvotes
        @event.upvotes = Float(this.get_upvotes.size)
      end

      def get_downvotes
        @event.downvotes = Float(this.get_downvotes.size)
      end
  end
end
