class Genre < ApplicationRecord
	extend FriendlyId
  friendly_id :name, use: [:slugged, :history]
	has_and_belongs_to_many :coins
end
