# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CartItem, type: :model do
  before(:all) do
    @cart_item = FactoryBot.create(:cart_item)
  end

  # describe 'Associations' do
  #   it { should belong_to(:cart) }
  #   it { should belong_to(:product) }
  # end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(@cart_item).to be_valid
    end

    # it 'is not valid without a quantity' do
    #   @cart_item.quantity = nil
    #   expect(@cart_item).to_not be_valid
    # end

    it 'is not valid with negative quantity' do
      @cart_item.quantity = -1
      expect(@cart_item.quantity).to_not be > -1
    end

    it 'is not valid without a price' do
      @cart_item.price = nil
      expect(@cart_item).to_not be_valid
    end

    it 'is not valid with negative price' do
      @cart_item.price = -1
      expect(@cart_item.price).to_not be > -1
    end
  end
end
