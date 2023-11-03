# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  before(:all) do
    @address = FactoryBot.create(:address)
  end

  describe 'Associations' do
    it { should belong_to(:user) }
  end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(@address).to be_valid
    end

    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :pincode }
  end
end
