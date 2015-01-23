require 'rails_helper'

RSpec.describe Trade, :type => :model do
  before :each do
    @user = create :user
    @category = create :category, user: @user
    @trade = build :trade, user: @user, category: @category
  end


  context "amount" do
    it "正の整数ならvalid" do
      expect(@trade).to be_valid
      @trade.amount = +100
      expect(@trade).to be_valid
    end

    it "0ならvalid" do
      @trade.amount = 0
      expect(@trade).to be_valid
    end

    it "負数数ならvalid" do
      @trade.amount = -3000
      expect(@trade).to be_valid
    end

    it "nilならinvalid" do
      @trade.amount = nil
      expect(@trade).not_to be_valid
      expect(@trade.errors[:amount]).to be_present
    end

    it "非数ならinvalid" do
      @trade.amount = "FFF"
      expect(@trade).not_to be_valid
      expect(@trade.errors[:amount]).to be_present
    end

    it "小数ならinvalid" do
      @trade.amount = 1.2345
      expect(@trade).not_to be_valid
      expect(@trade.errors[:amount]).to be_present
    end
  end

  context "trade_at" do
    it "日時文字列ならvalid" do
      expect(@trade).to be_valid
    end

    it "日時オブジェクトならvalid" do
      @trade.trade_at = DateTime.parse "2014-12-31 23:59:59"
      expect(@trade).to be_valid
    end

    it "日付オブジェクトならvalid" do
      @trade.trade_at = Date.parse "2014-12-31"
      expect(@trade).to be_valid
    end

    it "時間オブジェクトならvalid" do
      @trade.trade_at = Time.parse "23:59:59"
      expect(@trade).to be_valid
    end

    it "日時を表さないオブジェクトならinvalid" do
      @trade.trade_at = "XXX"
      expect(@trade).not_to be_valid
      expect(@trade.errors[:trade_at]).to be_present
    end
  end

  context "memo" do
    it "256文字以内ならvalid" do
      @trade.memo = "A" * 256
      expect(@trade).to be_valid
    end

    it "256文字よりながければinvalid" do
      @trade.memo = "A" * 257
      expect(@trade).not_to be_valid
      expect(@trade.errors[:memo]).to be_present
    end

    it "nilならvalid" do
      @trade.memo = nil
      expect(@trade).to be_valid
    end

    it "空文字ならvalid" do
      @trade.memo = ""
      expect(@trade).to be_valid
    end
  end

  context "user" do
    it "未設定ならinvalid" do
      @trade.user = nil
      expect(@trade).not_to be_valid
      expect(@trade.errors[:user]).to be_present
    end

    it "保存前のユーザーでもvalid" do
      @trade.user = build :user2
      expect(@trade).to be_valid
      expect(@trade.errors[:user]).to be_blank
    end
    j
    it "保存前のユーザーがtrade保存時に保存される" do
      user2 = build :user2
      @trade.user = user2
      @trade.save
      expect(User.find(user2.id)).to be_a_instance_of User
    end
  end
end
