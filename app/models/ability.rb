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
      can :manage, OrderItem
      can :search_products, Product
    end

    # return if user.blank?

    # can %i[update destroy], Order, { user: }
    # can :read, Order, user_id: user.id
    # can :manage, Product, user_id: user.id
    # can :manage, Order, user_id: user.id
    # can :manage, Cart, user_id: user.id
    # can :manage, OrderItem, user_id: user.id
    # can :manage, CartItem, user_id: user.id

  end
end
