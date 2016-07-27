class User < ActiveRecord::Base
  USER = "user"
  ADMIN = "admin"
  SYSTEM_ID = 1

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :orders, inverse_of: :user
  has_one :address
  has_one :credit_card
  validates_presence_of :name, :role

  after_create :do_mailer


  def do_mailer

    # Tell the UserMailer to send a welcome email after save
    UserMailer.welcome_email(self).deliver_later if !Rails.env.test?
  end
end
