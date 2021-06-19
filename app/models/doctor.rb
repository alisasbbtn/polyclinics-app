class Doctor < ApplicationRecord
  belongs_to :category
  has_many :appointments, dependent: :delete_all
  has_many :patients, through: :appointments
  has_one_attached :photo

  devise :database_authenticatable, :validatable, :validatable, authentication_keys: [:phone_number]

  validates :phone_number, presence: true, uniqueness: true, length: { is: 9 }, numericality: true
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :patronymic, presence: true, length: { maximum: 30 }
  validates_associated :category

  def full_name
    "#{last_name} #{first_name} #{patronymic}"
  end

  def available?
    appointments.active.count < 10
  end
end
