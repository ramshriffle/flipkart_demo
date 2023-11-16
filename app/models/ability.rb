# frozen_string_literal: true

# ability class
class Ability
  include CanCan::Ability

  def initialize(user)
    # user ||= User.new  # Guest user

    if user.type == 'Vendor'
      can :manage, Product
    elsif user.type == 'Customer'
      can :manage, Cart
      can :manage, Order
      can :manage, CartItem
      can :search_products, Product
    end
  end
end
