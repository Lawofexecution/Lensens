class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @trending_photographers = Role.where(title: "Photographe").first.users.take(2)
    @trending_filmmakers = Role.where(title: "Cinéaste").first.users.take(3)
    @trending_creators = @trending_photographers + @trending_filmmakers
    creators_ids = Role.left_outer_joins(:users).where("title = 'Photographe' or title='Cinéaste'").pluck(:user_id)
    @creators = User.where(id: creators_ids)
  end
end
