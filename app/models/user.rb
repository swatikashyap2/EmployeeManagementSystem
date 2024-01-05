class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  validates :first_name, presence: true
  validates :email, presence: true
  validates :role, presence: true
  validates :employee_code, presence: true
  validates :phone, uniqueness: true
  validates :role, uniqueness: true
  validates :employee_code, uniqueness: true

  scope :manager, -> {includes(:role).where(roles: {name: "manager"})}
  scope :employees, -> {includes(:role).where(roles: {name: "employee"})}
  scope :manager_employees, -> {includes(:role).where(roles: {name: ["manager","employee"]})}
  

end
