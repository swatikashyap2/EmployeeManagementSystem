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
  validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }
  validate :dob_on_or_before_current_date
  
   
  
  

  scope :manager, -> {includes(:role).where(roles: {name: "manager"})}
  scope :employees, -> {includes(:role).where(roles: {name: "employee"})}
  scope :manager_employees, -> {includes(:role).where(roles: {name: ["manager","employee"]})}
 
  

  has_many :user_leave_types
  has_many :leave_types, through: :user_leave_types




  
  enum :designation, {backend_developer: "backend_developer", frontend_developer: "frontend_developer", designer: "designer" }
  enum :gender, {male: "male", female: "female", other: "other"}


  def dob_on_or_before_current_date
    if dob.present? && dob > Date.current
      errors.add(:dob, "must be on or before the current date")
    end
  end
  
end
