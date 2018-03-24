class TripPlan < ApplicationRecord
  has_many :itineraries
  validates :title, :start_date, :end_date, presence: true

  validate :end_date_smaller_than_start_date

  def end_date_smaller_than_start_date
    return unless start_date && end_date && end_date < start_date
    errors.add(:end_date, "can't be smaller than start date")
  end
end
