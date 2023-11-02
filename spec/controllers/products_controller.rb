require 'rails_helper'
RSpec.describe ProductsController, type: :controller do
  include GenerateToken

  let(:user) {FactoryBot.create(:user, type: 'Vendor')}
  let(:product) { FactoryBot.create(:product, user_id: user.id)}
  let(:token) do
    generate_token(user)
  end
  let(:bearer_token) { "Bearer #{token}"}
  
  describe 'Get /products' do
    subject do
      request.headers['Authorization'] = bearer_token
      get 'index'
    end

    context 'without token' do
      let(:bearer_token) { '' }
      it "return unauthorized" do
        expect(subject).to have_http_status(401)
        expect(JSON.parse(subject.body)).to eq({"error"=>"Invalid token"})
      end
    end
    context 'with token' do
      context 'with valid token' do
        it 'returns all the jobs' do
          expect(subject).to have_http_status(200)
        end
      end
      
      context 'with invalid token' do
        let(:bearer_token) { 'dh92' }
        it 'return unauthorized' do
          expect(subject).to have_http_status(401)
        end
      end
    end
  end
end