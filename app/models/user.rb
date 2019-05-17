class User < ApplicationRecord 
  # acts_as_token_authenticatable
	acts_as_voter
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :coins
  has_many :questions, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :terms, dependent: :destroy
  has_many :key_players, dependent: :destroy
  has_many :moderated_coins, class_name: "Coin", :foreign_key => "moderator_id"
  has_many :comments, as: :commentable
  has_many :notifications, foreign_key: :recipient_id  
  has_many :citations
  # has_many :editor_files
  # has_many :favorites
  # has_many :flags, dependent: :destroy

  scope :admin_users, -> { where(admin: true) }

  validates :username, presence: :true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
  validate :validate_username
  #validates_acceptance_of :terms_of_service, :allow_nil => false, :accept => true, :on => :create
  
  def validate_username
    if User.where(email: username).exists?
      errors.add(:username, :invalid)
    end
  end

  # def login=(login)
  #   @login = login
  # end

  # def login
  #   @login || self.username || self.email
  # end

  # def favorites?(ob)
  # 	ob.favorites.where(user_id: id).first
  # end

  private 

    def picture_size
      if id_photo.size > 5.megabytes
        errors.add(:picture, "Picture must be smalled than 5MB.")
      end
    end

end
