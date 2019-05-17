class Post < ApplicationRecord
	#mount_uploader :picture, PictureUploader
	acts_as_votable

	belongs_to :user
	belongs_to :coin, optional: true

	has_many :comments, as: :commentable, dependent: :destroy
	has_many :users, through: :comments
	has_many :flags, dependent: :destroy
	has_many :favorites 

	validates :title, presence: true
	validates :content, presence: true	
	
	enum post_type:     [:general, :coin]
	enum post_category: [:coins, :news, :individuals, :state_of_crypto, :icos, :youtube, :podcasts, :memes]
	
end