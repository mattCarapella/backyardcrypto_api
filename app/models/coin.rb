class Coin < ApplicationRecord
  extend FriendlyId
  friendly_id :currency_name, use: [:slugged, :history, :finders]  
  scope :active_coins,   -> { where(accepted: true) }
  scope :inactive_coins, -> { where(accepted: false) }
  scope :pending_coins,  -> { where(pending: true) }

  has_many :questions, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :terms, dependent: :destroy
  has_many :key_players, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :favorites
  has_many :notifications#, dependent: :destroy
 
  # belongs_to :user
  #belongs_to :moderator, class_name: "User" , :foreign_key => "moderator_id",  optional: true
  
  has_and_belongs_to_many :genres
  
  validates :currency_name,   presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 100}
  validates :currency_abbrev, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 100} # currency_abbreviation is used in the cryptocompare API calls

  # mount_uploader :picture, PictureUploader
  # validate :picture_size

  #attr_accessor :moderator_email
  attr_accessor :price, :market_cap, :volume_24, :supply_24, :change_24 # all of these are temporary storage for cryptocompare data

  # before_save do
  #   if :moderator_email.present?
  #     self.moderator_id = User.find_by_email(moderator_email).id
  #   end
  # end

  def self.search(search)
    coins = all.where('accepted = ?', true).order('id ASC')
    coins = coins.where("currency_name like ? AND accepted = ?", "%#{search.capitalize}%", true) if search
    coins
  end


  def flop
    self.accepted = !self.accepted
    if self.accepted?
      self.pending = false
      self.rejected = false
    elsif !self.accepted?
      self.pending = true
    end
    self.save
  end

	def should_generate_new_friendly_id?
   	slug.blank? || self.currency_name_changed?
  end

  private

    # def picture_size
    #   if picture.size > 5.megabytes
    #     errors.add(:picture, "Picture must be smalled than 5MB.")
    #   end
    # end

    # def self.check_moderator_email(moderator_email)
    #    mod = User.where("email=?", moderator_email).first
    #    if mod.present?
    #       mod.update_attribute(:moderator, true) if not mod.moderator
    #       return true
    #    else
    #       return false
    #    end
    # end

end
