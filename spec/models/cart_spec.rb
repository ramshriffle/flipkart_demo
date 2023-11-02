require 'rails_helper'

RSpec.describe Cart, type: :model do
  before(:all) do
    @cart = FactoryBot.create(:cart)
  end

  describe 'Associations' do
    it { should belong_to(:customer) }
  end

  it 'is valid with valid attributes' do
    expect(@cart).to be_valid
  end
end
