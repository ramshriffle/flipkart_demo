# frozen_string_literal: true

require 'rails_helper'
RSpec.describe AuthenticationController, type: :controller do
  include GenerateToken

  let(:user) { FactoryBot.create(:user, verified: true) }

  describe 'POST login' do
    let(:params) { { email: user.email, password: user.password } }

    subject do
      post :login, params: params
    end

    context 'login user' do
      context 'email and password is correct' do
        it 'login successfully' do
          expect(subject).to have_http_status(200)
          # expect(JSON.parse(subject.body)). to eq({"message"=>"login successfully", "token"=>token})
        end
      end

      context 'email and password is wrong' do
        let(:params) { { email: 'abs', password: '' } }
        it 'login successfully' do
          expect(subject).to have_http_status(404)
          expect(JSON.parse(subject.body)).to eq({ 'message' => 'please check your email or password' })
        end
      end

      context 'user not verified for login' do
        let(:user) { FactoryBot.create(:user, verified: false) }
        let(:params) { { email: user.email, password: user.password } }
        it 'can not be login, user is not verified' do
          expect(JSON.parse(subject.body)).to eq({ 'message' => 'before login activate your account' })
        end
      end
    end
  end

  describe 'POST sent otp' do
    let(:params) { { email: user.email } }

    subject do
      post :sent_otp, params: params
    end

    context 'set otp user' do
      context 'email  is correct' do
        it 'otp sent successfully' do
          expect(subject).to have_http_status(200)
          expect(subject.body).to eq('otp successfully generated for login')
        end
      end

      context 'email  is wrong' do
        let(:params) { { email: 'abs' } }
        it 'otp not generate' do
          expect(subject).to have_http_status(404)
          expect(subject.body).to eq('Email not found, check your email')
        end
      end
    end
  end
end
