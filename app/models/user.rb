class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable
  belongs_to :role
  validates :first_name, presence: true
  validates :email, presence: true
  validates :role, presence: true
  validates :employee_code, presence: true, uniqueness: true
  validates :phone, uniqueness: true,numericality: { only_integer: true },length: { maximum: 12}, allow_blank: true

  scope :manager, -> {includes(:role).where(roles: {name: "manager"})}
  scope :employees, -> {includes(:role).where(roles: {name: "employee"})}
  scope :manager_employees, -> {includes(:role).where(roles: {name: ["manager","employee"]})}
  
  enum :designation, [ :developer, :frontend_developer, :designer ]
  enum :gender, [:male, :female, :other]
end
