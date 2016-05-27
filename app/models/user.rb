class User < ActiveRecord::Base
	USER = "user"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :orders, inverse_of: :user
	has_one :address
	has_one :credit_card
  validates_presence_of :name, :role
end
