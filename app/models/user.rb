class User < ApplicationRecord
 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :role


  scope :manager, -> {includes(:role).where(roles: {name: "Manager"})}
  scope :employees, -> {includes(:role).where(roles: {name: "Employee"})}
  
  

  def is_admin?
		self.role.name == "Admin" ? true : false
	end

	def is_manager?
		self.role.name == "Manager" ? true : false
	end

	def is_employee?
		self.role.name == "Employee" ? true : false
	end
end
