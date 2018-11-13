class Contact < ApplicationRecord
  # Associations
  belongs_to :user

  # Constants
  MOBILE_NUMBER_LENGTH = 10

  # Validations
  validates :name, presence: true
  validates :contact_number, presence: true, length: { is: Contact::MOBILE_NUMBER_LENGTH }
end
