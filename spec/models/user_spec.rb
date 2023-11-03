# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = FactoryBot.create(:user)
  end

  describe 'Validation' do
    it 'is valid with valid attributes' do
      expect(@user).to be_valid
    end

    it { should validate_presence_of :name }
    it { should validate_presence_of :username }
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :type }
    it { should validate_presence_of :mobile_no }

    it { should validate_uniqueness_of(:username).case_insensitive }
    it { should validate_uniqueness_of(:email).case_insensitive }

    it { should accept_nested_attributes_for(:addresses) }

    # it { should validate_uniqueness_of(:mobile_no) }
    # it { should validate_confirmation_of(:mobile_no).with_message(/\A^[6-9]\d{9}$\z/) }
    # it { should validate_format_of(:email).with_message(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i) }
  end

  # describe 'methods' do
    # it 'generate otp' do
    #   @user.generate_otp
    #   @user.otp = nil
    #   @user.otp_sent_at = nil
    #   expect(@user).to be_valid
    # end

    # it 'valid otp' do
    #   byebug
    #   @user.valid_otp
    #   expect( (@user.otp_sent_at + 5.seconds) > Time.now.utc).to eq "false"
    # end
  # end
end
