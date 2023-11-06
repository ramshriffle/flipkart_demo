# frozen_string_literal: true

require 'rails_helper'
RSpec.describe CartItemsController, type: :controller do
  include GenerateToken

  let(:user_v) { FactoryBot.create(:user, type: 'Vendor') }
  let(:product) { FactoryBot.create(:product, user_id: user_v.id) }
  let(:user_c) { FactoryBot.create(:user, type: 'Customer') }
  let(:cart) { FactoryBot.create(:cart, user_id: user_c.id) }
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
        it 'returns all cart_items' do
          byebug
          expect(subject).to have_http_status(200)
        end
      end

      context 'with valid token' do
        it 'cart_items is empty' do
          byebug
          expect(subject).to have_http_status(404)
          expect(JSON.parse(subject.body)).to eq({ 'message' => 'Cart is empty' })
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
    let(:params) { { id: cart_item.id } }

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
        context 'cart item found' do
          it 'returns cart_item' do
            byebug
            expect(subject).to have_http_status(200)
          end
        end

        # context 'cart item not found' do
        #   let(:params) { { id: 0 } }
        #   it 'cart item not found' do
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
            { quantity: cart_item.quantity, price: cart_item.price, product_id: product.id, cart_id: cart_item.cart_id }
          end
          it 'add item into the cart' do
            byebug
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

  describe 'PUT update' do
    let(:params) { { id: cart_item.id } }

    subject do
      request.headers['Authorization'] = bearer_token
      put :update, params: params
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
          let(:params) { { id: cart_item.id, quantity: 15 } }
          it 'return updated product' do
            byebug
            expect(subject).to have_http_status(200)
          end
        end

        context 'invalid params' do
          let(:params) { { id: cart_item.id, quantity: 0 } }
          it 'return unprocessable to update product' do
            byebug
            expect(subject).to have_http_status(422)
            expect(JSON.parse(subject.body)).to eq(['Quantity must be greater than or equal to 1'])
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
    let(:params) { { id: cart_item.id } }

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
        context 'cart item found' do
          it 'remove item from cart successfully' do
            byebug
            expect(subject).to have_http_status(200)
            expect(CartItem.count).to eq(0)
            expect(JSON.parse(subject.body)).to eq('message' => 'Cart item removed successfully')
          end
        end

        # context 'item not found in the cart' do
        #   let(:params) { { id: 0 } }
        #   it 'item not found' do
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
