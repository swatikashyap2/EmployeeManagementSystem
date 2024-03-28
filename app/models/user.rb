class User < ApplicationRecord
 
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable,
			:recoverable, :rememberable, :validatable
	has_many :user_leave_types
	has_many :leave_types, through: :user_leave_types
	has_many :leave_requests, dependent: :destroy 
	belongs_to :role
	has_many :notifications, dependent: :destroy
	belongs_to :reporting_manager,  class_name: 'User', foreign_key: 'reporting_manager_id', optional: true
	

	validates :first_name, presence: true
	validates :designation, presence: true
	validates :email, presence: true
	validates :role, presence: true
	validates :employee_code, presence: true, uniqueness: true
	validates :phone, uniqueness: true,numericality: { only_integer: true },length: { maximum: 12}, allow_blank: true
	validates :email, format: { with: /(\A([a-z]*\s*)*\<*([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\>*\Z)/i }
	validate :dob_on_or_before_current_date
	 
	has_one_attached :avatar


	after_create :assign_all_leave_types
	before_validation :set_default_password, on: :create
	before_validation :set_default_reporting_manager, on: :create

	scope :manager, -> {includes(:role).where(roles: {name: "manager"})}
	scope :employees, -> {includes(:role).where(roles: {name: "employee"})}
	scope :admin, -> {includes(:role).where(roles: {name: "admin"})}
	scope :search_result, -> (query) { where("first_name LIKE ?", "%#{query}%") }
	enum :designation, {backend_developer: "backend_developer", frontend_developer: "frontend_developer", designer: "designer" }
	enum :gender, {male: "male", female: "female", other: "other"}

	def dob_on_or_before_current_date
		if dob.present? && dob > Date.current
			errors.add(:dob, "must be on or before the current date")
		end
		if dob.present? && dob > 18.years.ago.to_date
			errors.add(:dob, "Please enter a valid date of birth. it should be greater then 18 years.")
		end
	end 

	def set_default_password
		if password.blank?
			self.password = "admin@123"
			self.password_confirmation = "admin@123"
		end
	end

	def set_default_reporting_manager
		admin_user = User.admin.first
		self.reporting_managers.push(admin_user.id ).compact! if admin_user
	end

	def image_url(style_name = :medium)
		image.url(style_name)
	end
	  
	  

	private

	def assign_all_leave_types
		LeaveType.all.each do |leave|
		user_leave_types.create(leave_type_id: leave.id, leave_count: leave.count, total_leave_count: leave.count)
		end
	end
end
