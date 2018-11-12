class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Constants
  NAME_MIN_LENGTH = 03
  NAME_MAX_LENGTH = 15
  AADHAR_LENGTH   = 12

  # Validations
  validates :first_name, :last_name, presence: true, length: { minimum: User::NAME_MIN_LENGTH, maximum: User::NAME_MAX_LENGTH }
  validates :aadhar_number, uniqueness: true, presence: true, length: { is: User::AADHAR_LENGTH }
end
