class CreateCitations < ActiveRecord::Migration[5.2]
  def change
    create_table :citations do |t|
    	t.bigint "question_id"  
	    t.string "author1_lname"
	    t.string "author1_fname"
	    t.string "author2_lname"
	    t.string "author2_fname"
	    t.string "author3_lname"
	    t.string "author3_fname"
	    t.string "author4_lname"
	    t.string "author4_fname"
	    t.string "author5_lname"
	    t.string "author5_fname"
	    t.string "author6_lname"
	    t.string "author6_fname"
	    t.date "date_of_last_revision"
	    t.date "date_of_publication"
	    t.date "date_of_retrieval"
	    t.datetime "created_at", null: false
	    t.datetime "updated_at", null: false
	    t.integer "user_id"
	    t.integer "source_num"

	    # WEBSITE
	    t.string "title"
			t.string "url"
			t.string "website_name"
			t.string "archive_url"
	    t.date "archive_date" 
	    t.string "language"
	    t.string "format"

	    # NEWS
	    t.string "work"
	    t.string "agency"
	    t.string "issue"
	    t.string "publisher"

	    # BOOK
	    t.string "isbn"
	    t.string "pages"
	    t.string "edition"

	    # JOURNAL
	    t.string "journal"
	    t.string "volume"
	    t.string "doi"
	    t.string "pmid"
	    t.date "access_date"

	    t.index ["question_id"], name: "index_citations_on_question_id"
    end
  end
end
