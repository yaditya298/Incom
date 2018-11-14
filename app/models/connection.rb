class Connection < ApplicationRecord

  # Associations
  belongs_to :contact
  belongs_to :group

  # Validations
  validates :group_id, presence: true, uniqueness: {scope: [:group_id, :contact_id]}
end
