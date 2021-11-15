class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    trending_photographers = Role.where(title: "Photographer").first.users.take(2)
    trending_filmmakers = Role.where(title: "Filmmaker").first.users.take(3)
    @trending_creators = trending_photographers + trending_filmmakers
  end
end
