require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:all) do
    @order = FactoryBot.create(:order)
  end

  describe 'Associations' do
    it { should belong_to(:customer) }
    it { should belong_to(:address) }
  end

  it 'is valid with valid attributes' do
    expect(@order).to be_valid
  end
end
