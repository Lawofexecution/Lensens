class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :bookings
  has_many :projects
  has_many :user_roles
  has_many :roles, through: :user_roles
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def short_name
    "#{first_name.capitalize} #{last_name.capitalize[0]}."
  end

  def unavailable_dates
    return []
   #bookings.pluck(:start_date, :end_date).map do |range|
    #  { from: range[0], to: range[1] }
    #end
  end
end
