class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    if params[:address].nil?
      @creators = Role.where("title ILIKE 'Photographer' OR title ILIKE 'Filmmaker' ").first.users
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
  end
end
