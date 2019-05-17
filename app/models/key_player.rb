class KeyPlayer < ApplicationRecord
	extend FriendlyId
  friendly_id :title, use: [:slugged, :finders, :history]
  acts_as_votable
  
  belongs_to :coin
  belongs_to :user
  
  validates :title, presence: true
  validates :caption, presence: true
  validates :content, presence: true
  validate :approve_only_one, on: :activate
  
  enum active_status: [:pending, :active, :inactive]

  private 

		def approve_only_one	
			accepted_answers = KeyPlayer.where('title=? AND coin_id=? AND active_status=?', self.title, self.coin_id, 1)
			unless accepted_answers.count < 1 
				errors.add :base, 'There can only be one accepted answer'
			end
		end

end
