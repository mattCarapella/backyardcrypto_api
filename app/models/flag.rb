class Flag < ApplicationRecord
  belongs_to :user
  belongs_to :question, optional: true
  belongs_to :post, optional: true
  belongs_to :coin, optional: true
end
