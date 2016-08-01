require 'rails_helper'

describe Admin::CategoriesHelper do
  describe "#existed?" do
    context "when the category is saved in DB" do
      it "returns true" do
        category = FactoryGirl.create(:category)
        expect(helper.existed?(category)).to eq(true)
      end
    end
    
    context "when the category is not saved in DB" do
      it "returns false" do
        category = FactoryGirl.build(:category)
        expect(helper.existed?(category)).to eq(false)
      end
    end
  end
end
