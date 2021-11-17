class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:address].nil?
      creators_ids = Role.left_outer_joins(:users).where("title = 'Filmmaker' or title='Photographer'").pluck(:user_id)
      @creators = User.where(id: creators_ids)
      @markers = @creators.geocoded.map do |creator|
        {
          lat: creator.latitude,
          lng: creator.longitude
        }
      end
    else
      @creators = User.near(params[:address], 1)
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
    @users = User.where.not(id: params[:id])
    @booking = Booking.new
  end
end
