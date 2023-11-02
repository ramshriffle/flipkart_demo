require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  before(:all) do
    @order_item = FactoryBot.create(:order_item)
  end
  
  # describe 'Associations' do
  #   it { should belong_to(:order) }
  #   it { should belong_to(:product) }
  # end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(@order_item).to be_valid
    end

    # it 'is not valid without a quantity' do
    #   @order_item.quantity = nil
    #   expect(@order_item).to_not be_valid
    # end

    it 'is not valid with negative quantity' do
      @order_item.quantity = -1
      expect(@order_item.quantity).to_not be > -1
    end

    it 'is not valid without a price' do
      @order_item.price = nil
      expect(@order_item).to_not be_valid
    end

    it 'is not valid with negative price' do
      @order_item.price = -1
      expect(@order_item.price).to_not be > -1
    end
  end
end
