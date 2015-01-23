require 'rails_helper'

RSpec.describe Category, :type => :model do
  context "validation" do
    before :each do
      @category = create(:category)
    end

    context "name" do
      it "nilならinvalid" do
        @category.name = nil
        expect(@category).not_to be_valid
        expect(@category.errors[:name]).to be_present
      end

      it "空文字ならinvalid" do
        @category.name = ""
        expect(@category).not_to be_valid
        expect(@category.errors[:name]).to be_present
      end

      it "長すぎるとinvalid" do
        @category.name = "a" * 129
        expect(@category).not_to be_valid
        expect(@category.errors[:name]).to be_present
      end

      it "適切な長さならinvalid" do
        @category.name = "a" * 128
        expect(@category).to be_valid
        expect(@category.errors[:name]).to be_blank
      end
    end

    context "color" do
      it "#f00ならvalid" do
        @category.color = "#f00"
        expect(@category).to be_valid
        expect(@category.errors[:color]).to be_blank
      end

      it "#00ff00ならvalid" do
        @category.color = "#00ff00"
        expect(@category).to be_valid
        expect(@category.errors[:color]).to be_blank
      end

      it "nilならinvalid" do
        category = Category.new name: "cateogry", color: nil
        expect(category).not_to be_valid
        expect(category.errors).to be_present
      end

      it "空文字ならinvalid" do
        category = Category.new name: "cateogry", color: ""
        expect(category).not_to be_valid
        expect(category.errors).to be_present
      end

      it "#0ならinvalid" do
        category = Category.new name: "cateogry", color: "#0"
        expect(category).not_to be_valid
        expect(category.errors).to be_present
      end

      it "#ffffggならinvalid" do
        category = Category.new name: "cateogry", color: "#ffffgg"
        expect(category).not_to be_valid
        expect(category.errors).to be_present
      end

      context "英字が大文字でも小文字で保存される" do
        it "作成時" do
          category = Category.new name: "cateogry", color: "#E6E6E6"
          expect(category.color).to be_eql "#E6E6E6"
        end
        it "保存時" do
          category = Category.create name: "cateogry", color: "#E6E6E6"
          expect(category.color).to be_eql "#e6e6e6"
        end
      end
    end
  end
end
