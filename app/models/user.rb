class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role


  scope :admin, -> {includes(:role).where(roles: {name: "Admin"})}
  scope :manager, -> {includes(:role).where(roles: {name: "Manager"})}
  scope :employee, -> {includes(:role).where(roles: {name: "Employee"})}
  scope :manager_employee, -> {includes(:role).where(roles: {name: ["Admin","Employee"]})}
  

  def is_admin?
    User.includes(:role).where(roles: {name: "Admin"})
  end

  def is_manager?
    User.includes(:role).where(roles: {name: "Manager"})
  end

  def is_employee?
    User.includes(:role).where(roles: {name: "Employee"})
  end
end
