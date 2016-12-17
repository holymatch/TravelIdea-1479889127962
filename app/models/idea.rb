class Idea < ApplicationRecord
  belongs_to :user
  has_many :comments
  
  validates :title, presence: true, length: { maximum: 255 }
  validates :destination, presence: true
  validates :start_date, presence: true
  validates :start_date, presence: true, date: { after_or_equal_to: Proc.new { Date.today }, message: "must be at least #{(Date.today + 1).to_s}" }, on: :create
  validates :end_date, presence: true, date: { after_or_equal_to:  :start_date}
  
  def self.search(keyword)
    where("title LIKE ? or destination LIKE ? or tags LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%")
  end
end
