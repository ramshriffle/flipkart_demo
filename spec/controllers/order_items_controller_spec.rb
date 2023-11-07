# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OrderItemsController, type: :controller do
  include GenerateToken

  let(:user_v) { FactoryBot.create(:user, type: 'Vendor') }
  let(:product) { FactoryBot.create(:product, user_id: user_v.id) }
  let(:user_c) { FactoryBot.create(:user, type: 'Customer') }
  let(:order) { FactoryBot.create(:order, user_id: user_c.id) }
  let(:order_item) { FactoryBot.create(:order_item, order_id: order.id, product_id: product.id) }

  let(:token) do
    generate_token(user_c)
  end
  let(:bearer_token) { "Bearer #{token}" }

  describe 'GET index' do
    let(:params) { { order_id: order_item.order_id } }

    subject do
      request.headers['Authorization'] = bearer_token
      get :index, params: params
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
        it 'returns all order items' do
          expect(subject).to have_http_status(200)
        end
      end

      context 'with valid token' do
        let(:params) { { order_id: 0 } }
        it 'order not found' do
          expect(subject).to have_http_status(404)
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
end
