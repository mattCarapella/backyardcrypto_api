class Citation < ApplicationRecord
  belongs_to :user
  belongs_to :question  
  validates :title, presence: true 
  validates :author1, presence: true 
end
