class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum gender: { male: 0, female: 1 }

  validates :phone_number, presence: true, uniqueness: true, length: { is: 9 }, format: { with: /\d{9}/ }
  validates :first_name, presence: true, length: { maximum: 30 }
  validates :last_name, presence: true, length: { maximum: 30 }
  validates :patronymic, presence: true, length: { maximum: 30 }
end
