class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :idea
  
  validates :content, presence: true, length: { maximum: 255 }
end
