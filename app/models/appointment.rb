class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  scope :active, -> { where(active: true) }
end
