class User < ApplicationRecord
  has_many :comments
  has_many :ideas
  
  # for change password
  attr_accessor :current_password
  attr_accessor :change_password
  
  before_save { self.email = email.downcase }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, :on => :create
  
  # bypass validate when use change their information, in this time, password and password_confirmation should been blank
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, :on => :update, unless: lambda{ |user| user.password.blank? && user.password_confirmation.blank?}
  
  # validate the password field when user is change password
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, if: :validate_password?,:on => :update
  # validate password when user is change password
  validate :current_password_is_correct, if: :validate_password?, on: :update
  
  # only change password page have change_password field and it's return ture
  def validate_password?
    !change_password.blank?
  end
  
  # check current password is correct before save
  def current_password_is_correct
    user = User.find_by_id(id)
    if (user.authenticate(current_password) == false)
      errors.add(:current_password, "is incorrect.")
    end
  end
end
