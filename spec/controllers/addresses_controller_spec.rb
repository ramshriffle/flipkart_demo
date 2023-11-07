# frozen_string_literal: true

require 'rails_helper'
RSpec.describe AddressesController, type: :controller do
  include GenerateToken

  let!(:user) { FactoryBot.create(:user) }
  let!(:address) { FactoryBot.create(:address, user_id: user.id) }
  let(:token) do
    generate_token(user)
  end
  let(:bearer_token) { "Bearer #{token}" }

  describe 'GET index' do
    subject do
      request.headers['Authorization'] = bearer_token
      get :index
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'return unauthorized' do
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq('error' => 'Invalid token')
      end
    end
    context 'with token' do
      context 'with valid token' do
        it 'returns all the addresses of user' do
          expect(subject).to have_http_status(200)
        end
      end

      context 'with invalid token' do
        let(:bearer_token) { "Bearer #{token}1" }
        it 'return unauthorized' do
          expect(subject).to have_http_status(401)
        end
      end
    end
  end

  describe 'GET show' do
    let(:params) { { id: address.id } }

    subject do
      request.headers['Authorization'] = bearer_token
      get 'show', params: params
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'return unauthorize' do
        expect(subject).to have_http_status(401)
      end
    end

    context 'with token' do
      context 'with valid token' do
        context 'address found' do
          it 'returns product' do
            expect(subject).to have_http_status(200)
          end
        end

        context 'address not found' do
          let(:params) { { id: 0 } }
          it 'address not found' do
            expect(subject).to have_http_status(404)
            expect(JSON.parse(subject.body)).to eq({ 'message' => 'Address not found' })
          end
        end
      end

      context 'with invalid token' do
        let(:bearer_token) { "Bearer #{token}1" }
        it 'returns unauthorize' do
          expect(subject).to have_http_status(401)
          expect(JSON.parse(subject.body)).to eq({ 'error' => 'Invalid token' })
        end
      end
    end
  end

  describe 'POST create' do
    let(:params) { {} }

    subject do
      request.headers['Authorization'] = bearer_token
      post :create, params: params
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'return unauthorize' do
        expect(subject).to have_http_status(401)
      end
    end

    context 'with token' do
      context 'with valid token' do
        context 'valid params' do
          let(:params) { { street: address.street, city: address.city, pincode: address.pincode, user_id: user.id } }
          it 'retrurn created new prodct' do
            expect(subject).to have_http_status(201)
            expect(JSON.parse(subject.body)).to eq('id' => 2, 'street' => address.street, 'city' => address.city,
                                                   'pincode' => address.pincode, 'user_id' => user.id)
          end
        end

        context 'invalid params' do
          let(:params) { { street: '', city: 'indore', pincode: 123_456 } }
          it 'return unprocessable entity' do
            expect(subject).to have_http_status(422)
            expect(JSON.parse(subject.body)).to eq(["Street can't be blank"])
          end
        end
      end

      context 'with invalid token' do
        let(:bearer_token) { "Bearer #{token}1" }
        it 'returns unauthorize' do
          expect(subject).to have_http_status(401)
          expect(JSON.parse(subject.body)).to eq({ 'error' => 'Invalid token' })
        end
      end
    end
  end

  describe 'DELETE destroy' do
    let(:params) { { id: address.id } }

    subject do
      request.headers['Authorization'] = bearer_token
      delete :destroy, params: params
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'return unauthorize' do
        expect(subject).to have_http_status(401)
      end
    end

    context 'with token' do
      context 'with valid token' do
        context 'product found' do
          it 'remove address successfully' do
            expect(subject).to have_http_status(200)
            expect(subject.body).to eq('Address remove successfully')
          end
        end

        context 'address not found' do
          let(:params) { { id: 0 } }
          it 'address not found' do
            expect(subject).to have_http_status(404)
            expect(JSON.parse(subject.body)).to eq({ 'message' => 'Address not found' })
          end
        end
      end

      context 'with invalid token' do
        let(:bearer_token) { "Bearer #{token}1" }
        it 'returns unauthorize' do
          expect(subject).to have_http_status(401)
          expect(JSON.parse(subject.body)).to eq({ 'error' => 'Invalid token' })
        end
      end
    end
  end
end
