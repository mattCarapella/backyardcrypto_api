class Link < ApplicationRecord
	# belongs_to :user
	belongs_to :coin
	
	validates :url, :format => URI::regexp(%w(http https))
	validates :websitename, presence: true
	#validates :exchange, presence: true
	validate :add_url_protocol

	scope :active_links,   -> { where(accepted: true) }
	scope :inactive_links, -> { where(rejected: true) }
	scope :pending_links,  -> { where(pending: true) }

	def add_url_protocol
	  if self.url && !url_protocol_present?
	    self.url = "http://#{self.url}"
	  end
	end

	def url_protocol_present?
	  self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
	end

end
