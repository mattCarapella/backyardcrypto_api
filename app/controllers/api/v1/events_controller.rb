module Api::V1 
  class EventsController < ApiController
    before_action :set_coin
    before_action :set_event, only: [:show, :update, :destroy]
    # before_action :authenticate_user!, except: [:calendar, :index]
    # load_and_authorize_resource

    def index     
      @pending_events  = @coin.events.pending
      @accepted_events = @coin.events.active
      @rejected_events = @coin.events.inactive
      today = Date.current 
      @upcoming_events = @accepted_events.where('start_time > ?', today)
      @past_events = @accepted_events.where('start_time < ?', today)
      @coin.events.each do |e|
        e.send('upvotes=', e.get_upvotes.size)
        e.send('downvotes=', e.get_downvotes.size)
      end
    end

    def calendar
      @events = @coin.events.active.where('start_time > ?', Date.today)
    end

    def show
      @nearby_events = @event.nearbys
    end

    def new
      #@event = current_user.events.build
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
        render json: @event, status: :updated
        @updated = true
      else
        render json: @event.errors, status: :unprocessable_entity
        @updated = false
      end
    end

    def destroy
      @event.destroy
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
      event.active_status = 1
      event.save!
    end

    def deactivate
      #authorize! :update, @event
      event = Event.find(params[:id])    
      event.active_status = 2
      event.save!
    end


    private

      def event_params
        params.require(:event).permit(:content, :link, :date, :start_time, :end_time, :time, :start_date, :end_date, 
          :venue, :street_address, :city, :state, :country, :zipcode, :description, :accepted, :latitude, :longitude, 
          :upvotes, :downvotes, :active_status)
      end
      
      def set_event
        @event = Event.find(params[:id])
      end

      def set_coin
        @coin = Coin.friendly.find(params[:coin_id])
      end

      def get_upvotes
        @event.upvotes = Float(this.get_upvotes.size)
      end

      def get_downvotes
        @event.downvotes = Float(this.get_downvotes.size)
      end
  end
end
