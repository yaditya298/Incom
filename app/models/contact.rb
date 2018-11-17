class Contact < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :connections, dependent: :destroy
  has_many :groups, through: :connections

  # Constants
  MOBILE_NUMBER_LENGTH = 10

  # Validations
  validates :name, presence: true, length: {
    minimum: User::NAME_MIN_LENGTH,
    maximum: User::NAME_MAX_LENGTH
  }
  
  domain = defined?(Domain) ? Domain.current.name : Domain::DEFAULT_DOMAIN
  validates :email,  presence: true, uniqueness: {
    scope: [:user_id, :email]
  },
  format: {
    with: Regexp.new('^[\w.+\-]+@' + domain.gsub('.', '\.') + '$'),
    multiline: true,
    message: I18n.t('contacts.errors.email_message', domain: domain)
  }

  validates :mobile, presence: true, uniqueness: {
    scope: [:user_id, :mobile]
  },
  length: { is: Contact::MOBILE_NUMBER_LENGTH }

  validate :cannot_add_self

  def cannot_add_self
    if email == user.email
      errors.add :base, I18n.t('contacts.errors.cannot_add_self')
    end
  end
end
