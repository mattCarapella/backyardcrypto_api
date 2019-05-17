module Api::V1   
  class CitationsController < ApiController
    before_action :set_citation, except: [:create, :new]
    before_action :set_coin
    before_action :set_question
    # before_action :authenticate_user!
   	# load_and_authorize_resource

    def new
      @citation = Citation.new
    end  

    def create
      @citation = @question.citations.new(citation_params)
      # @citation.user = current_user
      if @citation.save
        @new_citation_count = @question.citation_count + 1
        @question.update_attribute(:citation_count, @new_citation_count) 
        render json: @citation, status: :created
      else
        render json: @citation.errors, status: :unprocessable_entity
      end
    end

    def update
      if @citation.update(citation_params)
        render json: @citation, status: :ok
      else
        render json: @citation.errors, status: :unprocessable_entity
      end
    end

    def destroy
      if @citation.destroy 
        @new_citation_count = @question.citation_count - 1 
        @question.update_attribute(:citation_count, @new_citation_count)
      end
    end

    private 

      def citation_params 
        params.require(:citation).permit(:title, :author1_lname, :author1_fname, :author2_lname, :author2_fname, :author3_lname, :author3_fname, :author4_lname, :author4_fname, :author5_lname, :author5_fname, :author6_lname, :author6_fname, :publisher, :date_of_last_revision, :date_of_publication, :date_of_retrieval, :url, :isbn, :source_num, :website_name, :archive_url, :archive_date, :language, :format, :work, :agency, :issue, :pages, :edition, :journal, :volume, :doi, :pmid, :access_date)
      end
      
      def set_citation
        @citation = Citation.find(params[:id]) 
      end

      def set_coin
        @coin = Coin.friendly.find(params[:coin_id])
      end

      def set_question 
        @question = Question.find(params[:question_id])        
      end

  end
end