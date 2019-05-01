module Api::V1  
  class CoinsController < ApiController
    require "csv"

    #load_and_authorize_resource param_method: :question_params    # CANCANCAN
    #load_and_authorize_resource param_method: :event_params
    before_action :set_coin, only: [:show, :edit, :update]
    # before_action :authenticate_user!, except: [:index, :show]
    #before_action :get_submitted_picture, only: [:show, :create]
    before_action :get_pending_term_and_kp_counts, only: [:show]
    before_action :get_submission_count, only: :show
    before_action :set_user
    # before_action :get_localized_event_datetime, only: :show

    # rescue_from ActiveRecord::RecordNotFound do |exception|
    #   @query = params[:id].gsub(/[^\w-]/, '')
    #   @coins = Coin.where("currency_name LIKE ? or slug LIKE ?", "%#{@query}%", "%#{@query}%")
    #   render action: :search_rescue
    # end

    def index
      @coins = Coin.all.search(params[:currency_name])
      populate_coin_data
      @coins = @coins.sort_by(&:market_cap).reverse
    end

    def pending
      @pending_coins = Coin.pending_coins
    end

    def new
      @coin = Coin.new
    end

    def create
      #@coin = current_user.coins.build(coin_params)
      @coin = Coin.new(coin_params)
      if @coin.save
        render json: @coin, status: :created
      else
        render json: @coin.errors, status: :unprocessable_entity
      end
    end

    def show
      @coin = Coin.friendly.find(params[:id])

      # unless @coin.accepted or (current_user and current_user.admin?)
      #   redirect_to coins_path
      #   flash[:notice] = "Currency not found. Please choose from the following."
      # end

      # ------ Events ------- 
      @coin_events = @coin.events.order(:date)
      @pending_event_count = Event.pending_events.where("coin_id=?", @coin.id).count

      # @coin_events.each {
      #     |e|
      #     e.send('upvotes=', e.get_upvotes.size)
      #     e.send('downvotes=', e.get_downvotes.size)
      # }
      
      # ------ Links ------- 
      @coin_exchanges                 = Link.where("exchange=? AND accepted=? AND coin_id=?", true, true, @coin.id).order('websitename ASC')
      @other_links                    = Link.where("exchange=? AND accepted=? AND coin_id=?", false, true, @coin.id).order('websitename ASC')
      @pending_link_count             = Link.pending_links.where("coin_id=?", @coin.id).count

      # ------ Questions -------
      @overview_accepted              = Question.where("coin_id=? and ques_num=? and accepted=?", @coin.id, 1, true)[0]
      @history_accepted               = Question.where("coin_id=? and ques_num=? and accepted=?", @coin.id, 6, true)[0]
      @govmodel_accepted              = Question.where("coin_id=? and ques_num=? and accepted=?", @coin.id, 7, true)[0]
      @busmodel_accepted              = Question.where("coin_id=? and ques_num=? and accepted=?", @coin.id, 8, true)[0]
      @usecases_accepted              = Question.where("coin_id=? and ques_num=? and accepted=?", @coin.id, 9, true)[0]      
      @general_accepted = []
      @general_accepted << @overview_accepted
      @general_accepted << @history_accepted
      @general_accepted << @govmodel_accepted
      @general_accepted << @busmodel_accepted
      @general_accepted << @usecases_accepted

      @pending_brief_overview_count   = @coin.questions.where('ques_num=? and pending=?', 1, true).count
      @pending_history_count          = @coin.questions.where('ques_num=? and pending=?', 6, true).count
      @pending_govmodel_count         = @coin.questions.where('ques_num=? and pending=?', 7, true).count
      @pending_busmodel_count         = @coin.questions.where('ques_num=? and pending=?', 8, true).count
      @pending_comoutline_count       = @coin.questions.where('ques_num=? and pending=?', 9, true).count
      
      @open_topic_accepted            = Question.where("ques_num=? AND accepted=? AND coin_id=?",5, true, @coin.id).order("created_at ASC")
      @open_topic_submitted           = Question.where("ques_num=? AND pending=? AND coin_id=?", 5, true, @coin.id)
     
      #@open_topic_all = @coin.questions.where("ques_num=?", 5)
      #@open_topic_accepted, @open_topic_submitted = @open_topic_all.partition { |c| c.accepted? }
      #@open_topic_pending, @open_topic_archived   = @open_topic_submitted.partition { |c| c.pending? }

      # ------ Key Players / Terms ------
      @accepted_terms                 = @coin.terms.where("accepted=?", true)
      @accepted_key_players           = @coin.key_players.where("accepted=?", true)
      @pending_term_count             = Term.pending.where("coin_id=?", @coin.id).count
      @pending_kp_count               = KeyPlayer.pending.where("coin_id=?", @coin.id).count
      
      # ------ Posts -------
      @community_posts                = Post.where("coin_id=?", @coin).first(10)
  
      if current_user
        @favorite_coins               = @coin.favorites.where("user_id=?", current_user.id)
      end 

      populate_coin_data
    end

    def edit   
      # if params[:q].present?
      #   @question = Question.find_by_id(params[:q])
      #   @num = @question.ques_num

      #   if @question.present?
      #     authorize! :update, @coin
      #   else
      #     render file: "#{Rails.root}/public/404", status: :not_found
      #   end
      # else
      #   authorize! :update, @coin
      # end
    end

    def update
      mode = true
      mode = Coin.check_moderator_email(params[:coin][:moderator_email]) if params[:coin][:moderator_email].present?
      if mode
        @coin.moderator_id = User.find_by_email(params[:coin][:moderator_email]).id if params[:coin][:moderator_email].present?
        if @coin.save! && @coin.update_attributes(coin_params)
          #redirect_to coin_path(@coin)
          render json: @coin
        else
          render 'edit'
        end
      end
    end

    def destroy
      @coin = Coin.find(params[:id])
      if current_user.admin?
        @coin.destroy
      end
      render json: { status: 'SUCCESS', message: 'deleted the coin', data: @coin }
    end

    def flop
      # authorize! :destroy, @coin
      coin = Coin.find(params[:id])
      coin.flop

      # coin.accepted = !coin.accepted
      # if coin.accepted?
      #   coin.pending = false
      #   coin.rejected = false
      # elsif !coin.accepted?
      #   coin.pending = true
      # end
      # coin.save
      #redirect_to coin_path(coin)
    end
    
    private

      def coin_params
        if current_user.try(:admin?)
          params.require(:coin).permit(:moderator_email, :moderator_id, :currency_name, :currency_abbrev, :working_product, :founder,
            :mineable, :date_of_ico, :end_of_ico, :website, :reddit, :slack, :app, :github, :tradingview, :bitcointalk,
            :stackexchange, :coinmarketcap, :gitter, :blockexplorer, :tradingview, :bitcointalk,
            :bitfinex, :bithumb, :bitflyer, :hitbtc, :kucoin, :poloniex, :bitstamp, :bittrex,
            :gdax, :gemini, :btcc, :kraken, :korbit, :binance, :yorbit, :okcoin, :accepted, :picture,
            :coinmarket_id,:link_name, :money_raised_in_ico, :facebook, :twitter, :youtube, :whitepaper, :discord, :rank, genre_ids:[])
        else
          params.require(:coin).permit( :currency_name, :currency_abbrev, :working_product, :founder,
            :mineable, :date_of_ico, :end_of_ico, :website, :reddit, :slack, :app, :github, :tradingview, :bitcointalk,
            :stackexchange, :coinmarketcap, :gitter, :blockexplorer, :tradingview, :bitcointalk,
            :stackexchange, :bitfinex, :bithumb, :bitflyer, :hitbtc, :kucoin, :poloniex, :bitstamp, :bittrex,
            :gdax, :gemini, :btcc, :kraken, :korbit, :binance, :yorbit, :okcoin, :accepted, :picture,
            :coinmarket_id,:link_name, :money_raised_in_ico, :facebook, :twitter, :youtube, :whitepaper, :discord,:moderator_id, :rank, genre_ids:[])
        end
      end

      def set_coin 
        @coin = Coin.friendly.find(params[:id])
      end 

      def search
        @coins = Coin.order("rank ASC")
        @coins = @coins.search(params[:currency_name]).paginate(:page => params[:page], :per_page => 100)
        render json: {coins: @coins}
      end

      def set_user
        @user = current_user
      end

      # def get_public_ip_address
      #   require "open-uri"
      #   if request.remote_ip == '127.0.0.1'
      #     return open('https://api.ipify.org/').read
      #   else
      #     return request.remote_ip
      #   end
      # end

      def populate_coin_data
        if @coins
          coin_csv = @coins.map{|x| x.currency_abbrev}.to_csv
        else
          coin_csv = @coin.currency_abbrev
        end
        response = HTTParty.get("https://min-api.cryptocompare.com/data/pricemultifull?fsyms=#{coin_csv}&tsyms=USD&api_key=#{Rails.application.credentials.cryptocompare_api_key}")
        @data = response['RAW']
        if @data
          @data.each do |cryptocompare_coin|
            if @coins
              byc_coin = @coins.select { |x| x.currency_abbrev == cryptocompare_coin[0] }.first
            else
              byc_coin = @coin
            end
            byc_coin.price        = cryptocompare_coin[1]['USD']['PRICE']
            byc_coin.market_cap   = cryptocompare_coin[1]['USD']['MKTCAP']
            byc_coin.supply_24    = cryptocompare_coin[1]['USD']['SUPPLY']
            byc_coin.volume_24    = cryptocompare_coin[1]['USD']['VOLUME24HOURTO']
            byc_coin.change_24    = cryptocompare_coin[1]['USD']['CHANGEPCT24HOUR']
            byc_coin.market_cap   = 0 if byc_coin.market_cap == nil            
          end
        end
      end

      def get_submitted_picture
        cryptocompare_response = HTTParty.get("https://www.cryptocompare.com/api/data/coinlist/")
        if cryptocompare_response.present?
          if cryptocompare_response['Data']
            if @coin.currency_abbrev.present?
              @img_url_ = cryptocompare_response['BaseImageUrl'] + cryptocompare_response['Data'][@coin.currency_abbrev.upcase]['ImageUrl']
            end
          end
        end
        @found = Picture.find_by(coin_id: @coin.id, accepted: true)
        if @found
          @submitted_picture = @found.image.url
        elsif @img_url_
          @submitted_picture = @img_url_
        else
          @submitted_picture = nil
        end
        @coin.update_attribute(:picture, @submitted_picture)
      end

      def get_submission_count
        @included_topics    = @coin.questions.where('ques_num=? AND accepted=?', 5, true).map(&:open_topic)
        @open_topics        = @coin.questions.where('ques_num=? and pending=?', 5, true).select { |a| @included_topics.exclude? (a.open_topic)}
        @open_topic_count   = @coin.questions.where('ques_num=? and pending=?', 5, true).select { |a| @included_topics.exclude? (a.open_topic)}.count
      end

      def get_pending_term_and_kp_counts
        @pending_kp   = KeyPlayer.where("coin_id=? AND pending=?", @coin.id, true)
        @pending_term = Term.where("coin_id=? AND pending=?", @coin.id, true)

        if @pending_kp.any?
          @accepted_kp_titles = KeyPlayer.where("coin_id=? AND accepted=?", @coin.id, true).map { |t| t[:title] }
          @pending_kp = @pending_kp.reject { |t| @accepted_kp_titles.include?(t[:title]) }
        end
        if @pending_term.any?
          @accepted_term_titles = Term.where("coin_id=? AND accepted=?", @coin.id, true).map { |t| t[:title] }
          @pending_term = @pending_term.reject { |t| @accepted_term_titles.include?(t[:title]) }
        end
        @new_pending_terms_count = @pending_term.count
        @new_pending_kps_count = @pending_kp.count
      end

  end
end
