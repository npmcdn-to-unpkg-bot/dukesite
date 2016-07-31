require 'rails_helper'

describe Admin::CarouselsHelper do
  describe "#invisible_thumb?" do
    context "when the carousel is not visible" do
      it "returns 'invisible_thumbnail'" do
        carousel = FactoryGirl.build(:carousel, visible: false)
        expect(helper.invisible_thumb?(carousel)).to eq('invisible_thumbnail')
      end
    end
    
    context "when the carousel is visible" do
      it "returns nil" do
        carousel = FactoryGirl.build(:carousel, visible: true)
        expect(helper.invisible_thumb?(carousel)).to eq(nil)
      end
    end
  end
end
