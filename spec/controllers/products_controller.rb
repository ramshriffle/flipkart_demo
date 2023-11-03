# frozen_string_literal: true

require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  include GenerateToken

  let(:user) { FactoryBot.create(:user, type: 'Vendor') }
  let(:product) { FactoryBot.create(:product, user_id: user.id) }
  let(:token) do
    generate_token(user)
  end
  let(:bearer_token) { "Bearer #{token}" }

  describe 'Get products' do
    subject do
      request.headers['Authorization'] = bearer_token
      get :index
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'return unauthorized' do
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq("error"=>"Invalid token")
      end
    end
    context 'with token' do
      context 'with valid token' do
        it 'returns all the products' do
          expect(subject).to have_http_status(200)
        end
      end

      context 'with invalid token' do
        let(:bearer_token) { "Bearer #{token}"+"1" }
        it 'return unauthorized' do
          expect(subject).to have_http_status(401)
        end
      end
    end
  end

  describe 'GET show' do
    let(:params) {{id: product.id}}

    subject do
      request.headers['Authorization'] = bearer_token
      get 'show', params: params
    end

    context 'without token' do
      let(:bearer_token) {''}
      it 'return unauthorize' do
        expect(subject).to have_http_status(401)
      end
    end

    context 'with token' do
      context 'with valid token' do
        context 'product found' do
          it 'returns product' do
            expect(subject).to have_http_status(200)
          end
        end

        # context 'product not found' do
        #   let(:params) { {id: 0 } }
        #   it 'product not found' do 
        #     byebug  
        #     expect(subject).to have_http_status(404)
        #   end
        # end
      end

      context 'with invalid token' do
        let(:bearer_token) { "Bearer #{token}"+"1" }
        it 'returns unauthorize' do
          expect(subject).to have_http_status(401)
          expect(JSON.parse(subject.body)).to eq({"error"=>"Invalid token"})
         end
      end
    end
  end

  describe 'PUT update' do
    let(:params) { {id: product.id} }

    subject do
      request.headers['Authorization'] = bearer_token
      put :update, params: params
    end

    context 'without token' do
      let(:bearer_token) {''}
      it 'return unauthorize' do
        expect(subject).to have_http_status(401)
      end
    end

    context 'with token' do
      context 'with valid token' do
        context 'valid params' do
          let(:params) { {id: product.id, title: 'jacket' } }
          it 'returns updated product' do
            expect(subject).to have_http_status(200)
            # expect( JSON.parse(subject.body)).to eq("id"=> user.id, "name"=> 'ram', "username"=>user.username, "email"=>user.email, "mobile_no"=>user.mobile_no, "type"=>user.type, "profile_picture"=>nil )
          end
        end

        context 'invalid params' do
          let(:params) { {id: product.id, title: '' } }
          it 'unauthorize update to product' do
            expect(subject).to have_http_status(422)
            # expect( JSON.parse(subject.body)).to eq("errors"=>["Name can't be blank"])
          end
        end
      end

      context 'with invalid token' do
        let(:bearer_token) { "Bearer #{token}"+"1" }
        it 'returns unauthorize' do
          expect(subject).to have_http_status(401)
          expect(JSON.parse(subject.body)).to eq({"error"=>"Invalid token"})
         end
      end
    end
  end

end
