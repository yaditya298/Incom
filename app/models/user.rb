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

  # Callbacks
  after_create :add_admin

  # Attachments
  has_one_attached :avatar

  # Validations
  validates :first_name, :last_name, presence: true, length: {
    minimum: User::NAME_MIN_LENGTH,
    maximum: User::NAME_MAX_LENGTH
  }
  domain = defined?(Domain) ? Domain.current.name : Domain::DEFAULT_DOMAIN
  validates :email, presence: true, format: {
    with: Regexp.new('^[\w.+\-]+@' + domain.gsub('.', '\.') + '$'),
    multiline: true,
    message: I18n.t('contacts.errors.email_message', domain: domain)
  }

  validates :aadhar_number, uniqueness: true, presence: true, numericality: true, length: {
    is: User::AADHAR_LENGTH
  }

  # Custom Validators
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

  # This method is added temporarily to see the working mechanism of admin
  # This method has to be removed. The user who wants to be an admin can be updated from back end for any particular user.
  # From there that user can manage admin privilages
  def add_admin
    update_column(:role, 'admin')
  end
end
