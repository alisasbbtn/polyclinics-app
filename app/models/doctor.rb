class Doctor < ApplicationRecord
  belongs_to :category
  has_one_attached :photo

  devise :database_authenticatable

  validates :phone_number, presence: true, uniqueness: true, length: { is: 9 }, numericality: true
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :patronymic, presence: true, length: { maximum: 30 }
  validates_associated :category

  def full_name
    "#{last_name} #{first_name} #{patronymic}"
  end
end
