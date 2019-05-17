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

  def reply_to_comment_id(comment, nesting, max_nesting)
    # Use the comment as the parent if we allow for unlimited nesting or nesting is within max nesting 
    # limit. Otherwise use the comment's parent ID and limit nesting level to that of the parent.
    (max_nesting.blank? || nesting < max_nesting) ? comment.id : comment.parent_id
  end

end