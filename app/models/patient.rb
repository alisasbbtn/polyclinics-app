class Patient < ApplicationRecord
  has_many :appointments, dependent: :delete_all
  has_one_attached :photo

  devise :database_authenticatable, :registerable, :validatable

  enum gender: { male: 0, female: 1 }

  validates :phone_number, presence: true, uniqueness: true, length: { is: 9 }, numericality: true
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :patronymic, presence: true, length: { maximum: 30 }

  def full_name
    "#{last_name} #{first_name} #{patronymic}"
  end

  def age
    age = Date.today.year - birth_date.year
    age -= 1 if Date.today < birth_date + age.years
    age
  end

  def of?(doctor)
    appointments.where(doctor_id: doctor.id).exists?
  end
end
