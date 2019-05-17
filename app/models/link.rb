class Link < ApplicationRecord
	belongs_to :user
	belongs_to :coin
	
	validates :url, :format => URI::regexp(%w(http https))
	validates :websitename, presence: true
	validate  :add_url_protocol

	enum link_type: [:otherlink, :exchange]
	enum active_status: [:pending, :active, :inactive]

	def add_url_protocol
	  if self.url && !url_protocol_present?
	    self.url = "http://#{self.url}"
	  end
	end

	def url_protocol_present?
	  self.url[/\Ahttp:\/\//] || self.url[/\Ahttps:\/\//]
	end

end