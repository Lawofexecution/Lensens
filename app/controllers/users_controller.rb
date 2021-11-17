class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:index].nil?
      creators_ids = Role.left_outer_joins(:users).where("title = 'Cinéaste' or title='Photographe'").pluck(:user_id)
      @creators = User.where(id: creators_ids)
      @markers = @creators.geocoded.map do |creator|
        {
          lat: creator.latitude,
          lng: creator.longitude
        }
      end
    else
      role_input = params[:index][:role]
      creators_ids = Role.left_outer_joins(:users).where(title:role_input).pluck(:user_id)
      @creators = User.where(id: creators_ids)
      @creators = @creators.near(params[:index][:ville], 10)
      @markers = @creators.geocoded.map do |creator|
        {
          lat: creator.latitude,
          lng: creator.longitude
        }
      end
    end
  end

  def show
    @creator = User.find(params[:id])
    @booking = Booking.new
  end
end
