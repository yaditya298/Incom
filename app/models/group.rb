class Group < ApplicationRecord
  # Associations
  belongs_to :user
  has_many :connections, dependent: :destroy
  has_many :contacts, through: :connections

  # Constants
  TRUNCATE_LENGTH = 40

  # Validations
  validates :name, presence: true, length: {
    minimum: User::NAME_MIN_LENGTH,
    maximum: User::NAME_MAX_LENGTH
  }, uniqueness: { scope: [:user_id, :name] }
end
