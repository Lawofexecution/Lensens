class UsersController < ApplicationController
  def index
    trending_photographers = Role.where(title: "Photographer").first.users
    trending_filmmakers = Role.where(title: "Filmmaker").first.users
    @trending_creators = trending_photographers + trending_filmmakers
  end

  def show
    @creator = User.find(params[:id])
  end
end
