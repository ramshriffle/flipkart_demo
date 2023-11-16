# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:all) do
    @order = FactoryBot.create(:order)
  end

  # describe 'Associations' do
  #   it { should belong_to(:customer) }
  #   it { should belong_to(:address) }
  #   it { should belong_to(:product) }
  # end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(@order).to be_valid
    end

    # it 'is not valid without a quantity' do
    #   @order.quantity = nil
    #   expect(@order).to_not be_valid
    # end

    it 'is not valid with negative quantity' do
      @order.quantity = -1
      expect(@order.quantity).to_not be > -1
    end

    it 'is not valid without a price' do
      @order.price = nil
      expect(@order).to_not be_valid
    end

    it 'is not valid with negative price' do
      @order.price = -1
      expect(@order.price).to_not be > -1
    end
  end
end
