class Post < ApplicationRecord
	acts_as_votable
	validates :title, presence: true
	validates :content, presence: true

	#belongs_to :user
	belongs_to :coin, optional: true
	has_many :comments, as: :commentable, dependent: :destroy
	#has_many :users, through: :comments
	has_many :flags, dependent: :destroy
	has_many :favorites 
	
	#mount_uploader :picture, PictureUploader

	enum post_type: [:general, :coin]
	enum post_category: [:coins, :news, :individuals, :state_of_crypto, :icos, :youtube, :podcasts, :memes]
	# Post.post_categories --> shows hash of all
	# Post.news --> all 'news' posts
	# @post.news? --> returns true if 'news' post
end