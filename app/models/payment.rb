class Payment < ActiveRecord::Base
  belongs_to :credit_card, inverse_of: :payments
  belongs_to :order
  validates_presence_of :amount, :order, :credit_card, :state

  self.state_machine({
     pending: [:completed],
     completed: [:voided],
     voided: []
  })

  before_transition_to :completed do
    puts "PAYMENT STATE MOVED TO COMPLETED"
  end
end