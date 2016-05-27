class CreditCard < ActiveRecord::Base
	belongs_to :user
	has_many :payments, inverse_of: :credit_card
  validates_presence_of :last_four, :month, :year, :user, :name
  validates_presence_of :number, :cvc,
                        on: :create
  attr_accessor :number, :cvc

  before_validation :set_last_four

  def expiration_date
    DateTime.parse("#{self.year}-#{self.month}-01").end_of_month
  end

  private
  def set_last_four
    return if self.number.blank?
    if CreditCardValidator::Validator.valid?(self.number)
      self.last_four = self.number.last(4)
    end
  end



end
