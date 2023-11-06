# frozen_string_literal: true

require 'rails_helper'
RSpec.describe UsersController, type: :controller do
  include GenerateToken

  let(:user) { FactoryBot.create(:user) }
  let(:token) do
    generate_token(user)
  end
  let(:bearer_token) { "Bearer #{token}" }

  describe 'Post create' do
    subject do
      request.headers['Authorization'] = bearer_token
      post :create
    end
  end

  describe 'Get show' do
    let(:params) { { id: user.id } }

    subject do
      request.headers['Authorization'] = bearer_token
      get :show
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'return unauthorize' do
        expect(subject).to have_http_status(401)
      end
    end

    context 'with token' do
      context 'with valid token' do
        it 'returns user' do
          expect(subject).to have_http_status(200)
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
    let(:params) { {} }

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
          let(:params) { { user: { name: 'ram' } } }
          it 'returns user' do
            expect(subject).to have_http_status(200)
            expect(JSON.parse(subject.body)).to eq('id' => user.id, 'name' => 'ram', 'username' => user.username,
                                                   'email' => user.email, 'mobile_no' => user.mobile_no, 'type' => user.type, 'profile_picture' => nil)
          end
        end

        context 'invalid params' do
          let(:params) { { user: { name: '' } } }
          it 'unauthorize user' do
            expect(subject).to have_http_status(422)
            expect(JSON.parse(subject.body)).to eq('errors' => ["Name can't be blank"])
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
    subject do
      request.headers['Authorization'] = bearer_token
      put :destroy
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it 'return unauthorize' do
        expect(subject).to have_http_status(401)
      end
    end

    context 'with token' do
      context 'with valid token' do
        it 'user delete successfully' do
          expect(subject).to have_http_status(200)
          expect(JSON.parse(subject.body)).to eq('message' => 'Account deleted successfully!!')
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
