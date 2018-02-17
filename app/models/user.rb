class User < ApplicationRecord
  after_initialize :set_default_role, :if => :new_record?

  validates :name, presence: true
  validates :email, uniqueness: true, email: true
  validates :role, presence: true

  def set_default_role
    self.role ||= 'guest' 
  end

  def set_role(role)
    raise "#{role} is undefined" unless ['admin', 'board', 'guest']
    self.role = role
  end

  def admin?
    self.role == 'admin'
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
