class Role < ApplicationRecord
  validates :role_type, presence: true
  validates :name, presence: true

  has_many :users
end
