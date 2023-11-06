# frozen_string_literal: true

require 'rails_helper'
RSpec.describe AddressesController, type: :controller do
  include GenerateToken

  let(:user) { FactoryBot.create(:user) }
  let(:address) { FactoryBot.create(:address, user_id: user.id) }
  let(:token) do
    generate_token(user)
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
        it 'returns all the addresses of user' do
          byebug
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
            byebug
            expect(subject).to have_http_status(200)
          end
        end

        # context 'address not found' do
        #   let(:params) { { id: 0 } }
        #   it 'address not found' do
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

  # describe 'POST create' do
  #   let(:params) { {} }

  #   subject do
  #     request.headers['Authorization'] = bearer_token
  #     post :create, params: params
  #   end

  #   context 'without token' do
  #     let(:bearer_token) { '' }
  #     it 'return unauthorize' do
  #       expect(subject).to have_http_status(401)
  #     end
  #   end

  #   context 'with token' do
  #     context 'with valid token' do
  #       context 'valid params' do
  #         let(:params) { { title: product.title, description: product.description, category: product.category, quantity:product.quantity, price: product.price, rating: product.rating, user_id:user.id } }
  #         it 'retrurn created new prodct' do
  #           expect(subject).to have_http_status(200)
  #           expect( JSON.parse(subject.body)).to eq("id"=>2, "title"=>product.title, "description"=>product.description, "category"=>product.category, "quantity"=>product.quantity, "price"=>"100.0", "rating"=>product.rating, "user_id"=>product.user_id, "image"=>nil )
  #         end
  #       end

  #       context 'invalid params' do
  #         let(:params) { { id: product.id, title: '' } }
  #         it 'return unprocessable entity' do
  #           expect(subject).to have_http_status(422)
  #         end
  #       end
  #     end

  #     context 'with invalid token' do
  #       let(:bearer_token) { "Bearer #{token}1" }
  #       it 'returns unauthorize' do
  #         expect(subject).to have_http_status(401)
  #         expect(JSON.parse(subject.body)).to eq({ 'error' => 'Invalid token' })
  #       end
  #     end
  #   end
  # end

  # describe 'PUT update' do
  #   let(:params) { { id: product.id } }

  #   subject do
  #     request.headers['Authorization'] = bearer_token
  #     put :update, params: params
  #   end

  #   context 'without token' do
  #     let(:bearer_token) { '' }
  #     it 'return unauthorize' do
  #       expect(subject).to have_http_status(401)
  #     end
  #   end

  #   context 'with token' do
  #     context 'with valid token' do
  #       context 'valid params' do
  #         let(:params) { { id: product.id, title: 'jacket' } }
  #         it 'return updated product' do
  #           expect(subject).to have_http_status(200)
  #           expect( JSON.parse(subject.body)).to eq("id"=>product.id, "title"=>"jacket", "description"=>product.description, "category"=>product.category, "quantity"=>product.quantity, "price"=>"100.0", "rating"=>product.rating, "user_id"=>product.user_id, "image"=>nil )
  #         end
  #       end

  #       context 'invalid params' do
  #         let(:params) { { id: product.id, title: '' } }
  #         it 'return unprocessable to update product' do
  #           byebug
  #           expect(subject).to have_http_status(422)
  #           expect( JSON.parse(subject.body)).to eq(["Title can't be blank"])
  #         end
  #       end
  #     end

  #     context 'with invalid token' do
  #       let(:bearer_token) { "Bearer #{token}1" }
  #       it 'returns unauthorize' do
  #         expect(subject).to have_http_status(401)
  #         expect(JSON.parse(subject.body)).to eq({ 'error' => 'Invalid token' })
  #       end
  #     end
  #   end
  # end

  # describe 'DELETE destroy' do
  #   let(:params) { { id: product.id } }

  #   subject do
  #     request.headers['Authorization'] = bearer_token
  #     delete :destroy, params: params
  #   end

  #   context 'without token' do
  #     let(:bearer_token) { '' }
  #     it 'return unauthorize' do
  #       expect(subject).to have_http_status(401)
  #     end
  #   end

  #   context 'with token' do
  #     context 'with valid token' do
  #       context 'product found' do
  #         it 'delete product successfully' do
  #           expect(subject).to have_http_status(200)
  #           expect(JSON.parse(subject.body)).to eq("message"=>"Product delete successfully")
  #         end
  #       end

  #       # context 'product not found' do
  #       #   let(:params) { {id: 0} }
  #       #   it 'product not found' do
  #       #     expect(subject).to have_http_status(404)
  #       #   end
  #       # end
  #     end

  #     context 'with invalid token' do
  #       let(:bearer_token) { "Bearer #{token}1" }
  #       it 'returns unauthorize' do
  #         expect(subject).to have_http_status(401)
  #         expect(JSON.parse(subject.body)).to eq({ 'error' => 'Invalid token' })
  #       end
  #     end
  #   end
  # end
end
