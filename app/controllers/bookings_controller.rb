class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    booking = Booking.new(booking_params)
    booking.client_id = current_user.id
    booking.creator_id = params[:user_id]
    booking.status = "pending"

    if !booking.save
      puts booking.errors.full_messages
    end
    redirect_to bookings_index_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
