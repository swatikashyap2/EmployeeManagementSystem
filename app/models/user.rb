class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  belongs_to :role


  scope :manager, -> {includes(:role).where(roles: {name: "manager"})}
  scope :employees, -> {includes(:role).where(roles: {name: "employee"})}
  scope :manager_employees, -> {includes(:role).where(roles: {name: ["manager","employee"]})}
  

end
