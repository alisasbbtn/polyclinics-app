class Patient < ApplicationRecord
  has_one_attached :photo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum gender: { male: 0, female: 1 }

  validates :phone_number, presence: true, uniqueness: true, length: { is: 9 }, format: { with: /\d{9}/ }
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :patronymic, presence: true, length: { maximum: 30 }
  validates :photo, attached: true

  def full_name
    "#{last_name} #{first_name} #{patronymic}"
  end

  def age
    age = Date.today.year - birth_date.year
    age -= 1 if Date.today < birth_date + age.years
    age
  end
end
