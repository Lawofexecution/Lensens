class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :bookings
  has_many :projects
  has_many :roles, through: :user_roles
  has_many :user_roles
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
