module Api::V1   
  class CitationsController < ApiController
    before_action :set_coin
    before_action :set_question
    before_action :authenticate_user!
   	load_and_authorize_resource

    def new
      @citation = Citation.new
    end  

    def create
      @citation = @question.citations.new(citation_params)
      @citation.user = current_user 
      respond_to do |format| 
        if @citation.save!
          @new_citation_count = @question.citation_count + 1
          @citation.update_attribute(:source_num, @new_citation_count)
          @question.update_attribute(:citation_count, @new_citation_count)
          format.html { redirect_to coin_question_path(@coin, @question.id) }
          format.json { render :show, status: :created, location: @citation }
        else
          format.html { render :new }
          format.json { render json: @citation.errors, status: :unprocessable_entity }
        end
      end
    end

    def edit
    end

    def update
      @citation = Citation.find(params[:id])
      if @citation.update(citation_params)
        redirect_to coin_question_path(@coin, @question.id)
      else
        redirect_to 'edit'
      end
    end

    def destroy
      @citation = Citation.find(params[:id])
      @citation.destroy 
      @new_citation_count = @question.citation_count - 1 
      @question.update_attribute(:citation_count, @new_citation_count)
      redirect_to coin_question_path(@coin, @question.id)
    end

    private 

      def set_coin
        @coin = Coin.friendly.find(params[:coin_id])
      end

      def set_question 
        @question = Question.find(params[:question_id]) 
        
      end

      def citation_params 
        params.require(:citation).permit(:title, :author1_lname, :author1_fname, :author2_lname, :author2_fname, :author3_lname, :author3_fname, :author4_lname, :author4_fname, :author5_lname, :author5_fname, :author6_lname, :author6_fname, :publisher,
                      :date_of_last_revision, :date_of_publication, :date_of_retrieval, :url, :isbn, :source_num, :website_name, :archive_url, :archive_date, :language, :format, :work, :agency, :issue, :pages, :edition, :journal, :volume, :doi, :pmid, :access_date)
      end

  end
end