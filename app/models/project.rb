class Project < ApplicationRecord

  # Validate presence of required fields
  validates :key, presence: true
  validates :menu_text, presence: true
  validates :name, presence: true
  validates :description, presence: true

end
