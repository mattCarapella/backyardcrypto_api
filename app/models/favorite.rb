class Favorite < ApplicationRecord
	#belongs_to :user
	belongs_to :coin, optional: true 
	belongs_to :post, optional: true
end
