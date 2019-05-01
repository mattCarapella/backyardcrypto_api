class Question < ApplicationRecord
	acts_as_votable
	belongs_to :user
	belongs_to :coin
  validate :approve_only_one, on: :activate
	has_many :citations
	# has_many :question_images, dependent: :destroy
	has_many :comments, as: :commentable, dependent: :destroy
	has_many :flags, dependent: :destroy

	scope :is_accepted, -> { where(accepted: true) }
	scope :is_inactive, -> { where(rejected: true) }
	scope :is_pending,  -> { where(pending: true) }

	
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
				accepted_answers = Question.where(coin_id: self.coin.id, ques_num: self.ques_num, accepted: true)
				unless accepted_answers.count < 1 
					errors.add :base, 'There can only be one accepted answer'
				end
			elsif self.ques_num == 5 
				accepted_answers = Question.where(coin_id: self.coin.id, ques_num: self.ques_num, open_topic: self.open_topic, accepted: true)
				unless accepted_answers.count < 1 
					errors.add :base, 'There can only be one accepted answer'
				end
			end
		end  

end
