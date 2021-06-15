class Category < ApplicationRecord
  has_many :doctors

  validates :title, presence: true, uniqueness: true
end
