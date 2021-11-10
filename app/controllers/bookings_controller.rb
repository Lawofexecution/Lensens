class BookingsController < ApplicationController
  def index
    @bookings = Booking.all
  end

  def create
    booking = booking.new
    # we need `restaurant_id` to associate booking with corresponding restaurant
    booking.client_id = current_user.id
    booking.creator_id = params[:user_id]
    booking.status = "pending"
    booking.save
    redirect_to booking_index_path
  end

end
