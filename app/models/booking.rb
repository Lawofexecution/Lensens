# class AvailabilityValidator < ActiveModel::EachValidator

#   def validate_each(record, attribute, value)
#     bookings = Booking.where(["creator_id =?", record.creator_id])
#     date_ranges = bookings.map { |b| b.start_date..b.end_date }

#     date_ranges.each do |range|
#       if range.include? value
#         record.errors.add(attribute, "not available")
#       end
#     end
#   end
# end

class Booking < ApplicationRecord
  belongs_to :client, class_name: "User"
  belongs_to :creator, class_name: "User"
  #validates :start_date, :end_date, presence: true
  #validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end
