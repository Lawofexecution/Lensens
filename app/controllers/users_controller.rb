class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @creators = Role.where("title ILIKE 'Photographer' OR title ILIKE 'Filmmaker' ").first.users
    @markers = @creators.geocoded.map do |creator|
      {
        lat: creator.latitude,
        lng: creator.longitude
      }
    end
  end

  def show
    @creator = User.find(params[:id])
  end
end
