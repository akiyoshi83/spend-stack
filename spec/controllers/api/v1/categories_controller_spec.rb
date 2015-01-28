require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, :type => :controller do

  render_views

  before do
    @user = create :user
    session[:user_id] = @user.id
  end

  describe 'GET index' do
    context 'has categories' do
      before :each do
        @categories = [
          create(:category, name: '食費', user: @user),
          create(:category, name: '光熱費', user: @user),
        ]
        get :index, format: :json
      end

      it 'returns 200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'assign categories' do
        expect(assigns(:categories)).to eq @categories
      end

      it 'returns json' do
        json = JSON.parse(response.body)
        expect(json[0]['name']).to match /食費/
        expect(json[1]['name']).to match /光熱費/
      end
    end

    context 'no categories' do
      before :each do
        get :index, format: :json
      end

      it 'returns 200 OK' do
        expect(response).to be_success
        expect(response.status).to eq(200)
      end

      it 'assign categories' do
        expect(assigns(:categories)).to eq []
      end

      it 'returns empty json' do
        json = JSON.parse(response.body)
        expect(json.length).to eq 0
      end
    end
  end


end
