class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :contacts

  # Constants
  NAME_MIN_LENGTH = 3
  NAME_MAX_LENGTH = 15
  AADHAR_LENGTH   = 12
  PASSWORD_REGEX = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,24}$/

  # Attachments
  has_one_attached :avatar

  # Validations
  validates :first_name, :last_name, presence: true, length: {
    minimum: User::NAME_MIN_LENGTH,
    maximum: User::NAME_MAX_LENGTH
  }
  validates :aadhar_number, uniqueness: true, presence: true, length: {
    is: User::AADHAR_LENGTH
  }
  validate :password_complexity

  def password_complexity
    return if password.blank? || password.match?(PASSWORD_REGEX)
    errors.add :password, 'must include atleast 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end
end
