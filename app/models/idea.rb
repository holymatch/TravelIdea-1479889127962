class Idea < ApplicationRecord
  belongs_to :user
  has_many :comments
  
  def self.search(keyword)
    where("title LIKE ? or destination LIKE ? or tags LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end
end
