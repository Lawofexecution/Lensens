class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index ]

  def index
    if !params[:index].nil? && (!params[:index][:role].blank? || !params[:index][:ville].blank?)

      creators_ids = Role.left_outer_joins(:users).where(title: params[:index][:role]).pluck(:user_id)
      @creators = User.where(id: creators_ids)

      if params[:index][:ville].blank?
        @creators = @creators.near(params[:index][:ville], 10)
      end

      @markers = @creators.geocoded.map do |creator|
        {
          lat: creator.latitude,
          lng: creator.longitude
        }
      end
    else
      creators_ids = Role.left_outer_joins(:users).where("title = 'Vidéaste' or title='Photographe' ").pluck(:user_id)
      @creators = User.where(id: creators_ids)
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
    creators_ids = Role.left_outer_joins(:users).where("title = 'Photographe' or title='Vidéaste'").pluck(:user_id)
    @creators = User.where(id: creators_ids)
    @booking = Booking.new
  end
end
