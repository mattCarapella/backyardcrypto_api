class Comment < ApplicationRecord
	acts_as_votable
  validates :body, presence: true
	
  belongs_to :user 
  belongs_to :commentable, polymorphic: true
  belongs_to :parent, optional: true, class_name: "Comment"
  belongs_to :coin, optional: true 
  
  # every comment in thread points to parent. Parent id is used to organize comments as nested thread
  def comments
  	Comment.where(commentable: commentable, parent_id: id)
  end

end