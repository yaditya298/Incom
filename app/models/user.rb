class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  # Associations
  has_many :contacts, dependent: :destroy
  has_many :groups, dependent: :destroy

  # Constants
  NAME_MIN_LENGTH = 3
  NAME_MAX_LENGTH = 30
  AADHAR_LENGTH   = 12
  PASSWORD_REGEX  = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,24}$/

  # Attachments
  has_one_attached :avatar

  # Validations
  validates :first_name, :last_name, presence: true, length: {
    minimum: User::NAME_MIN_LENGTH,
    maximum: User::NAME_MAX_LENGTH
  }
  if defined? Domain
    validates :email, presence: true, format: {
      with: Regexp.new('^[\w.+\-]+@' + Domain.current.name.gsub('.', '\.') + '$'),
      multiline: true,
      message: I18n.t('contacts.errors.email_message', domain: Domain.current.name)
    }
  end
  validates :aadhar_number, uniqueness: true, presence: true, length: {
    is: User::AADHAR_LENGTH
  }
  validate :password_complexity

  def password_complexity
    return if password.blank? || password.match?(PASSWORD_REGEX)
    errors.add :password, 'must include atleast 1 uppercase, 1 lowercase, 1 digit and 1 special character'
  end

  def admin?
    role == 'admin'
  end

  def full_name
    [first_name, last_name].join(' ').titleize
  end
end
