class Project < ApplicationRecord

  # Validate presence of required fields
  validates :key, presence: true, alphabetic: true
  validates :menu_text, presence: true
  validates :name, presence: true
  validates :description, presence: true

  # Validate github link is HTTPS, if present
  validates :github_link, HTTPS: true

end
