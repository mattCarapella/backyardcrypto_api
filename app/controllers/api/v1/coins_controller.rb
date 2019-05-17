module Api::V1  
  class CoinsController < ApiController
    require "csv" 

    #load_and_authorize_resource param_method: :question_params    # CANCANCAN
    #load_and_authorize_resource param_method: :event_params
    before_action :set_coin, only: [:show, :edit, :update]
    #before_action :authenticate_user!#, except: [:index, :show]
    before_action :get_pending_term_and_kp_counts, only: [:show]
    before_action :get_submission_count, only: :show
    # before_action :get_localized_event_datetime, only: :show

    # rescue_from ActiveRecord::RecordNotFound do |exception|
    #   @query = params[:id].gsub(/[^\w-]/, '')
    #   @coins = Coin.where("currency_name LIKE ? or slug LIKE ?", "%#{@query}%", "%#{@query}%")
    #   render action: :search_rescue
    # end

    def index
      @coins = Coin.where("active_status=?", 1)
      # @coins = Coin.all.search(params[:currency_name])
      populate_coin_data if @coins.any?
    end

    def pending
      @pending_coins = Coin.where("active_status=?", 0)
    end

    def new
      @coin = Coin.new
    end

    def create
      # @coin = current_user.coins.build(coin_params)
      @coin = Coin.new(coin_params)
      if @coin.save
        render json: @coin, status: :created
      else
        render json: @coin.errors, status: :unprocessable_entity
      end
    end

    def show
      # ------ Events ------- 
      @coin_events = @coin.events.where("active_status=?", 1)
      # @coin_events.each {
      #     |e|
      #     e.send('upvotes=', e.get_upvotes.size)
      #     e.send('downvotes=', e.get_downvotes.size)
      # }
       
      # ------ Links ------- 
      @coin_exchanges                 = @coin.links.where("exchange=? AND active_status=?", true, 1).order('websitename ASC')
      @other_links                    = @coin.links.where("exchange=? AND active_status=?", false, 1)

      # ------ Questions -------
      @accepted_questions = @coin.questions.where("active_status=?", 1)          
      @general_accepted = []
      @general_accepted << @accepted_questions.where("ques_num=?", 1)[0]
      @general_accepted << @accepted_questions.where("ques_num=?", 6)[0]
      @general_accepted << @accepted_questions.where("ques_num=?", 7)[0]
      @general_accepted << @accepted_questions.where("ques_num=?", 8)[0]
      @general_accepted << @accepted_questions.where("ques_num=?", 9)[0] 
      @open_topic_accepted = @coin.questions.where("ques_num=? AND active_status=?", 5, 1)

      # ------ Key Players / Terms ------
      @accepted_terms                 = @coin.terms.where("active_status=?", 1)
      @accepted_key_players           = @coin.key_players.where("active_status=?", 1)
      
      # ------ Posts -------
      @community_posts                = Post.where("coin_id=?", @coin).first(10)
  
      if current_user
        @favorite_coins               = @coin.favorites.where("user_id=?", current_user.id)
      end 
 
      get_submitted_picture if !@coin.picture
      populate_coin_data
    end

    def edit   
      if params[:q].present?
        @question = Question.find_by_id(params[:q])
        @num = @question.ques_num
        if @question.present?
          authorize! :update, @coin
        else
          render file: "#{Rails.root}/public/404", status: :not_found
        end
      else
        authorize! :update, @coin
      end
    end

    def update
      if @coin.save! && @coin.update_attributes(coin_params)
        render json: @coin, status: :ok
      else
        render json: @coin.errors, status: :unprocessable_entity
      end

      # mode = true
      # mode = Coin.check_moderator_email(params[:coin][:moderator_email]) if params[:coin][:moderator_email].present?      
      #   @coin.moderator_id = User.find_by_email(params[:coin][:moderator_email]).id if params[:coin][:moderator_email].present?
      #   if @coin.save! && @coin.update_attributes(coin_params)
      #     #redirect_to coin_path(@coin)
      #     render json: @coin
      #   else
      #     render 'edit'
      #   end
      # end
    end

    def destroy
      @coin = Coin.friendly.find(params[:id])
      # if current_user.admin?
        @coin.destroy
      # end
    end

    def flop
      # authorize! :destroy, @coin
      @coin = Coin.friendly.find(params[:id])
      if @coin.active_status == 0 or @coin.active_status == 2
        @coin.active_status = 1
      elsif @coin.active_status == 0 or @coin.active_status == 1
        @coin.active_status = 2
      end
      @coin.save
    end

    private

      def coin_params
        if current_user.try(:admin?)
          params.require(:coin).permit(:moderator_email, :moderator_id, :currency_name, :currency_abbrev, :working_product, 
            :founder, :mineable, :date_of_ico, :end_of_ico, :website, :reddit, :slack, :app, :github, :tradingview, 
            :bitcointalk, :stackexchange, :coinmarketcap, :gitter, :blockexplorer, :tradingview, :bitcointalk,
            :bitfinex, :bithumb, :bitflyer, :hitbtc, :kucoin, :poloniex, :bitstamp, :bittrex, :gdax, :gemini, :btcc, 
            :kraken, :korbit, :binance, :yorbit, :okcoin, :accepted, :picture, :coinmarket_id,:link_name, 
            :money_raised_in_ico, :facebook, :twitter, :youtube, :whitepaper, :discord, :rank, :active_status, genre_ids:[])
        else
          params.require(:coin).permit(:currency_name, :currency_abbrev, :working_product, :founder,
            :mineable, :date_of_ico, :end_of_ico, :website, :reddit, :slack, :app, :github, :tradingview, :bitcointalk,
            :stackexchange, :coinmarketcap, :gitter, :blockexplorer, :tradingview, :bitcointalk,
            :stackexchange, :bitfinex, :bithumb, :bitflyer, :hitbtc, :kucoin, :poloniex, :bitstamp, :bittrex,
            :gdax, :gemini, :btcc, :kraken, :korbit, :binance, :yorbit, :okcoin, :accepted, :picture,
            :coinmarket_id,:link_name, :money_raised_in_ico, :facebook, :twitter, :youtube, :whitepaper, :discord, 
            :moderator_id, :rank, :active_status, genre_ids:[])
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
        if response.values[0] != "Error"   
          @data = response['RAW']
          if @data
            @data.each do |cryptocompare_coin|
              if cryptocompare_coin[1]
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
              end       
            end     
          end
        end
      end

      def get_submitted_picture
        cryptocompare_response = HTTParty.get("https://www.cryptocompare.com/api/data/coinlist/")
        if cryptocompare_response.present?
          if cryptocompare_response['Data']      
            if @coin.currency_abbrev.present? && cryptocompare_response['Data'][@coin.currency_abbrev.upcase] && cryptocompare_response['Data'][@coin.currency_abbrev.upcase].values[5].downcase == @coin.currency_name.downcase
                @img_url_ = cryptocompare_response['BaseImageUrl'] + cryptocompare_response['Data'][@coin.currency_abbrev.upcase]['ImageUrl']
            end
          end
        end
        @found = Picture.find_by(coin_id: @coin.id, active_status: 1)
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
        @included_topics  = @coin.questions.where('ques_num=? AND active_status=?', 5, 1).map(&:open_topic)
        @open_topics      = @coin.questions.where('ques_num=? and active_status=?', 5, 0).select { |a| @included_topics.exclude? (a.open_topic)}
        @open_topic_count = @open_topics.size
      end

      def get_pending_term_and_kp_counts
        @pending_kp   = @coin.key_players.where("active_status=?", 0)
        @pending_term = @coin.terms.where("active_status=?", 0)
        if @pending_kp.any?
          @accepted_kp_titles = @coin.key_players.where("active_status=?", 1).map { |t| t[:title] }
          @pending_kp = @pending_kp.reject { |t| @accepted_kp_titles.include?(t[:title]) }
        end
        if @pending_term.any?
          @accepted_term_titles = @coin.terms.where("active_status=?", 1).map { |t| t[:title] }
          @pending_term = @pending_term.reject { |t| @accepted_term_titles.include?(t[:title]) }
        end
        @new_pending_terms_count = @pending_term.size
        @new_pending_kps_count = @pending_kp.size
      end

  end
end
