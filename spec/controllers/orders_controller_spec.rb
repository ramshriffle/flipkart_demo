# frozen_string_literal: true

require 'rails_helper'
RSpec.describe OrdersController, type: :controller do
  include GenerateToken

  let(:user_v) { FactoryBot.create(:user, type: 'Vendor') }
  let(:product) { FactoryBot.create(:product, user_id: user_v.id) }
  let(:user_c) { FactoryBot.create(:user, type: 'Customer') }
  let!(:order) { FactoryBot.create(:order, user_id: user_c.id) }
  let(:cart) { FactoryBot.create(:cart, user_id: user_c.id) }
  let(:order_item) { FactoryBot.create(:order_item, order_id: order.id, product_id: product.id) }
  let(:cart_item) { FactoryBot.create(:cart_item, cart_id: cart.id, product_id: product.id) }

  let(:token) do
    generate_token(user_c)
  end
  let(:bearer_token) { "Bearer #{token}" }

  describe 'Get index' do
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
        it 'returns all order' do
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
    let(:params) { { id: order.id } }

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
        context 'order found' do
          it 'returns order' do
            expect(subject).to have_http_status(200)
          end
        end

        context 'order not found' do
          let(:params) { { id: 0 } }
          it 'order not found' do
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

  describe 'POST buy now' do
    let(:params) { {} }

    subject do
      request.headers['Authorization'] = bearer_token
      post :buy_now, params: params
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
          let(:params) do
            { order: { user_id: order.user_id, address_id: order.address_id,
                       order_items_attributes: [quantity: 1, product_id: order_item.product_id] } }
          end
          it 'retrurn created new order' do
            expect(subject).to have_http_status(201)
            # expect( JSON.parse(subject.body)).to eq("id"=>2, "title"=>product.title, "description"=>product.description, "category"=>product.category, "quantity"=>product.quantity, "price"=>"100.0", "rating"=>product.rating, "user_id"=>product.user_id, "image"=>nil )
          end
        end

        context 'invalid params' do
          let(:params) { { order: { user_is: order.user_id, address_id: nil } } }
          it 'return unprocessable entity' do
            expect(subject).to have_http_status(422)
            expect(JSON.parse(subject.body)).to eq('errors' => ['Address must exist'])
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
    let(:params) { { id: order.id } }

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
        context 'order found' do
          it 'delete order successfully' do
            expect(subject).to have_http_status(200)
            expect(JSON.parse(subject.body)).to eq('message' => 'Order cancel succssefully')
          end
        end

        context 'order not found' do
          let(:params) { { id: 0 } }
          it 'order not found' do
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
          let(:params) do
            { order: { user_id: order.user_id, address_id: order.address_id,
                       order_items_attributes: [quantity: cart_item.quantity, product_id: cart_item.product_id] } }
          end
          it 'retrurn created new order' do
            expect(subject).to have_http_status(201)
            # expect( JSON.parse(subject.body)).to eq("id"=>2, "title"=>product.title, "description"=>product.description, "category"=>product.category, "quantity"=>product.quantity, "price"=>"100.0", "rating"=>product.rating, "user_id"=>product.user_id, "image"=>nil )
          end
        end

        context 'invalid params' do
          let(:params) do
            { order: { user_id: order.user_id, address_id: nil,
                       order_items_attributes: [quantity: cart_item.quantity, product_id: cart_item.product_id] } }
          end
          it 'return unprocessable entity' do
            expect(subject).to have_http_status(422)
            expect(JSON.parse(subject.body)).to eq({ 'errors' => ['Address must exist'] })
          end
        end

        context 'cart is empty' do
          let(:params) { { order: { user_is: order.user_id, address_id: order.address_id } } }
          it 'return cart not found' do
            expect(subject).to have_http_status(404)
            expect(subject.body).to eq('Cart is empty')
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
