require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # subject {
  #   @user = FactoryBot.create(:user)
  #   byebug
  # }
  before(:all) do
    @user = FactoryBot.create(:user)
    byebug
  end
          
  it "is valid with valid attributes" do
    expect(@user).to be_valid
  end 
end
