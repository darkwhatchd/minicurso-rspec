require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "PUT /enemies" do
    context "when the enemy exists" do
      let(:enemy) { create(:enemy) }
      let(:enemy_attributes) { attributes_for(:enemy) }
      
      before(:each) do
        put "/enemies/#{enemy.id}", params: enemy_attributes
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'updates the record' do
        expect(enemy.reload).to have_attributes(enemy_attributes)
      end

      it 'returns the enemy updated' do       
        expect(enemy.reload).to have_attributes(json.except('created_at', 'updated_at'))
      end
    end
    
    context "when the enemy does not exist" do
      before(:each) do
        put '/enemies/0', params: attributes_for(:enemy)
      end

      it 'returns the status code 404' do
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
    
  end

  describe "DELETE /enemies" do
    let(:enemy) { create(:enemy) }

    context "when the enemy exists" do
      before(:each) do
        delete "/enemies/#{enemy.id}"
      end

      it "returns status code 204" do
        expect(response).to have_http_status(204)
      end

      it "destroy the record" do        
        #expect{
        #  delete "/enemies/#{enemy.id}"
        #}.to change(Enemy, :count)
        # OU
        expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end
    
    context "when the enemy does not exist" do
      before(:each) do
        delete '/enemies/0'
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end

  describe "POST /enemies" do
    let(:enemy_attributes) { attributes_for(:enemy) }

    context "Created with correct attibutes" do
      before(:each) do
        post '/enemies', params: enemy_attributes
      end

      it 'return status code 200' do
        expect(response).to have_http_status(:success)
      end
      it 'create the enemy' do
        expect(Enemy.count).to eq(1)
      end
    end

    context "Created with incorrect attributes" do
      let(:enemy_attributes_incorrect) { attributes_for(:enemy, level: 0) }
      before(:each) do
        post '/enemies', params: enemy_attributes_incorrect
      end

      it 'returns status code 422' do
        expect(response).to  have_http_status(:unprocessable_entity)
      end
      it 'returns a error message' do
        expect(response.body).to match(/must be greater than 0/)
      end
    end
  end

  describe "GET /enemies" do
    let(:enemy_attributes) { attributes_for(:enemy) }
    before(:each) do
      post '/enemies', params: enemy_attributes
      get '/enemies.json'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /enemies/:id" do
    let(:enemy_attributes) { attributes_for(:enemy) }

    before(:each) do
      post '/enemies', params: enemy_attributes
    end

    context 'Enemy exists' do
      it 'returns status code 200' do
        get "/enemies/#{json['id']}.json"
        expect(response).to have_http_status(:success)
      end

    end

    context "enemy dont exist" do
      before(:each) do
        get '/enemies/0.json'
      end

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns an error message' do
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end
  end
end
