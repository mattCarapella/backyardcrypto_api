class Question < ApplicationRecord	
	acts_as_votable

	belongs_to :user
	belongs_to :coin
	
	has_many :citations
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :flags, dependent: :destroy
	
	validate :approve_only_one, on: :activate
	
	enum active_status: [:pending, :active, :inactive]
	enum ques_num: [:q0, :overview, :q2, :q3, :q4, :open_topic, :history, :goverence_model, :business_model, :use_cases]
	
	def get_approval_rating
		total_upvotes = self.get_upvotes.size
    total_downvotes = self.get_downvotes.size
    total_num_votes = Float(total_upvotes + total_downvotes)
    (total_upvotes/total_num_votes*100).round(2)
	end

  private 

		def approve_only_one
			if self.ques_num == 1 or self.ques_num == 6 or self.ques_num == 7 or 
						self.ques_num == 8 or self.ques_num == 9
				accepted_answers = Question.where(coin_id: self.coin.id, ques_num: self.ques_num, active_status: 1)
				unless accepted_answers.size < 1 
					errors.add :base, 'There can only be one accepted answer'
				end
			elsif self.ques_num == 5 
				accepted_answers = Question.where(coin_id: self.coin.id, ques_num: self.ques_num, open_topic: self.open_topic, active_status: 1)
				unless accepted_answers.size < 1 
					errors.add :base, 'There can only be one accepted answer'
				end
			end
		end  

end
