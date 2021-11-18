class BookingsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :create]

  def index
    @client_bookings = Booking.where(client_id: current_user.id)
    @creator_bookings = Booking.where(creator_id: current_user.id)
  end

  def new
    @client_bookings = Booking.where(client_id: current_user.id)
    @creator_bookings = Booking.where(creator_id: current_user.id)
  end

  def update
    booking = Booking.find(params[:id])
    booking.update(update_booking_params)
    redirect_to new_user_booking_path
  end

  def create
    booking = Booking.new(booking_params)
    booking.client_id = current_user.id
    booking.creator_id = params[:user_id]
    booking.status = "En attente"

    if !booking.save
      puts booking.errors.full_messages
    end
    redirect_to new_user_booking_path(current_user.id)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

   def update_booking_params
    params.require(:booking).permit(:status)
  end
end
