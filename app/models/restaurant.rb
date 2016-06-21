class Restaurant < ApplicationRecord

  # Autocode: Relationships
  belongs_to :user

  # Autocode: Accept Nested Attributes

  # File Upload

  # Autocode: Validations
  validates_uniqueness_of :name
  validates_presence_of :name

  # Autocode: Callbacks

	# Soft Destroy

end
