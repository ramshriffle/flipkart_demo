# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CartsController, type: :controller do
  include GenerateToken

  let(:user) { FactoryBot.create(:user, type: 'Customer') }
  let(:cart) { FactoryBot.create(:cart, user_id: user.id) }

  let(:token) do
    generate_token(user)
  end
  let(:bearer_token) { "Bearer #{token}" }

  describe 'GET show' do
    let(:params) { { id: cart.id } }

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
        context 'cart found' do
          it 'returns cart' do
            expect(subject).to have_http_status(200)
            expect(JSON.parse(subject.body)).to eq({ 'id' => cart.id, 'user_id' => cart.user_id })
          end
        end

        context 'cart not found' do
          let(:params) { { id: 0 } }
          it 'cart not found' do
            expect(subject).to have_http_status(404)
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
    let(:params) { { id: cart.id } }

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
        context 'cart found' do
          it 'delete product successfully' do
            expect(subject).to have_http_status(200)
            expect(JSON.parse(subject.body)).to eq('message' => 'Cart deleted successfully!!')
          end
        end

        # context 'cart not found' do
        #   let(:params) { { id: 0 } }
        #   it 'cart not found' do
        #     expect(subject).to have_http_status(404)
        #   end
        # end
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
