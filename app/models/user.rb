class User < ApplicationRecord
  has_many :comments
  has_many :ideas
  #attr_accessor :password
  
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, :on => :create
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, :on => :update, unless: lambda{ |user| user.password.blank? && user.password_confirmation.blank?}
end
