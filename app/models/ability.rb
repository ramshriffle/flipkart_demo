# frozen_string_literal: true

# ability class
class Ability
  include CanCan::Ability

  def initialize(user)
    debugger
    # user ||= User.new  # Guest user

    if user.type == 'Vendor'
      can :manage, Product
    elsif user.type == 'Customer' 
      can :manage, Cart
      can :manage, Order
      can :manage, CartItem
      can :manage, OrderItem
      can :read, :all
    end
  end
end
