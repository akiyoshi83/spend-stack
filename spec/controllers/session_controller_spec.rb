require 'rails_helper'

RSpec.describe SessionController, :type => :controller do

  describe "GET create" do
    it "returns http success", skip: 'TODO' do
      get :create
      expect(response).to be_success
    end
  end

  describe "GET destroy" do
    it "returns http success", skip: 'TODO' do
      get :destroy
      expect(response).to be_success
    end
  end

end
