class Group < ApplicationRecord
  # Associations
  belongs_to :user

  # Validations
  validates :name, presence: true, length: {
    minimum: User::NAME_MIN_LENGTH,
    maximum: User::NAME_MAX_LENGTH
  }, uniqueness: { scope: [:user_id, :name] }
end
