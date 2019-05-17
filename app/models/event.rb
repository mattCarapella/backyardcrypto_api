class Event < ApplicationRecord 
  acts_as_votable
	
  belongs_to :user
  belongs_to :coin

  enum active_status: [:pending, :active, :inactive]
  
  scope :later_events, Proc.new { |current = DateTime.now, limit = 7| where('date > ?', current).order("date ASC").limit(limit) }
  scope :prior_events, Proc.new { |current = DateTime.now, limit = 3| where('date < ?', current).order("date DESC").limit(limit) }

  geocoded_by :address
  validates :content, presence: true
  validates :city, presence: true
  after_validation :geocode, if: :address_changed?

  def address 
  	[street_address, city, zipcode, state].compact.join(", ")
  end

  def address_changed? 
  	street_address_changed? || city_changed? || zipcode_changed? || state_changed?
  end

end
