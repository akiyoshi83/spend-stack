require 'rails_helper'

RSpec.describe User, :type => :model do
  before :each do
    @user = create(:user)
  end

  context "validatioin" do
    it 'providerがないとinvalid' do
      user = User.new(uid: '99999')
      expect(user).not_to be_valid
      expect(user.errors[:provider]).to be_present
    end

    it 'uidがないとinvalid' do
      user = User.new(provider: 'twitter')
      expect(user).not_to be_valid
      expect(user.errors[:uid]).to be_present
    end

    it 'providerとuidがあればvalid' do
      user = User.new(provider: 'twitter', uid: '99999')
      expect(user).to be_valid
      expect(user.errors[:provider]).to be_blank
      expect(user.errors[:uid]).to be_blank
    end

    it 'providerとuidがユニークでないとinvalid' do
      user = User.new(provider: @user.provider, uid: @user.uid)
      expect(user).not_to be_valid
      expect(user.errors[:uniqueness_user]).to be_present
    end

    it 'image_urlがURL形式でないとinvalid' do
      @user.image_url = "foobar"
      expect(@user).not_to be_valid
      expect(@user.errors[:image_url]).to be_present
    end
  end

end
