# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:all) do
    @product = FactoryBot.create(:product)
  end

  it 'is valid with valid attributes' do
    expect(@product).to be_valid
  end

  it 'is invalid without title' do
    @product.title = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid without description' do
    @product.description = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid without category' do
    @product.category = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid without quantity' do
    @product.quantity = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid without price' do
    @product.price = nil
    expect(@product).to_not be_valid
  end

  it 'is invalid without rating' do
    @product.rating = nil
    expect(@product).to_not be_valid
  end

  describe 'Associations' do
    it { should belong_to(:vendor) }
  end
end
