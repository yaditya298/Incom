class Domain < ApplicationRecord
  # Associations
  belongs_to :added_by, class_name: 'User', optional: true

  # Scopes
  scope :current, -> { where(current: true).first }

  # Validationa
  validates :name, presence: true, uniqueness: true

  # Constants
  DEFAULT_DOMAIN = 'inmar.com'
  DEFAULT_REGEXP = Regexp.new('^[\w.+\-]+@' + Domain::DEFAULT_DOMAIN.gsub('.', '\.') + '$')
end
