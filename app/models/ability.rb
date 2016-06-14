class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud

    user ||= User.new # guest user (not logged in)
    if user.persisted?
      if user.role == User::ADMIN
        can :crud, Product
        can  :access, :admin
      end

      can [:index, :address, :billing, :checkout], :cart
      can :crud, Address, user_id: user.id
    end
  end
end
