class Ability
  include CanCan::Ability
  
  def initialize(user)  
    # user ||= User.new # guest user (not logged in)
    # if user.type == 'Vendor'
    #   can :manage, create
    # else
    #   can :manage, Order  
    #   can :manage, OrderItem 
    #   can :manage, Cart 
    #   can :manage, CartItem
    #   can :read, Product
    # end


    user ||= User.new  # Guest user

    if user.type == 'Vendor'
      can :manage, Product
    elsif user.type == 'Customer'
      can :read, :all
      cannot :create, :Product
      can [:update, :destroy], User, id: user_id
      can :manage, Cart
      can :manage, Order
      can :manage, CartItem
      can :manage, OrderItem
    end
  end
  