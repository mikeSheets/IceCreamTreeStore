class Payment < ActiveRecord::Base
  belongs_to :credit_card, inverse_of: :payments
  belongs_to :order
  validates_presence_of :amount, :order, :credit_card, :state

  PENDING = "pending"
  COMPLETED = "completed"
  VOIDED = "voided"

  STATES = [PENDING, COMPLETED, VOIDED]
  validates(:state, inclusion: STATES)

  before_save :validate_state_change

  after_initialize :set_default_state

  def validate_state_change
    old, nib = changed_attributes["state"]
    nib = state
    old_index = STATES.index(old)
    new_index = STATES.index(nib)

    if !persisted?
      errors.add(:state, "initial state must be #{STATES.first}") if self.state != STATES.first
    elsif new_index.nil?
      errors.add(:state, "#{new} is not a valid state")
    elsif (new_index) != (old_index + 1)
      errors.add(:state, "Cannot transition from #{nib} to #{old}")
    end
    errors.empty?
  end

  def set_default_state
    self.state ||= STATES.first
  end
end
