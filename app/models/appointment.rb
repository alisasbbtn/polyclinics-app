class Appointment < ApplicationRecord
  belongs_to :patient
  belongs_to :doctor

  paginates_per 15

  default_scope -> { order datetime: :desc }
  scope :active, -> { where(active: true) }

  validates :datetime, presence: true
  validate :valid_date

  def status
    if closed?
      'closed'
    elsif past?
      'past'
    else
      'active'
    end
  end

  def past?
    datetime < DateTime.now.beginning_of_day
  end

  def closed?
    !active
  end

  private

  def valid_date
    errors.add(:datetime, :wrong_time) if datetime.hour < 9 || datetime.hour > 17
  end
end
