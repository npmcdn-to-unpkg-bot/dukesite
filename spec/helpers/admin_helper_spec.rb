require 'rails_helper'

describe AdminHelper do
  let(:published_article) { FactoryGirl.build(:article, :published) }
  let(:published_article) { FactoryGirl.build(:article, :published) }
  let(:unpublished_article) { FactoryGirl.build(:article, :unpublished) }
  let(:published_product) { FactoryGirl.build(:product, :published) }
  let(:unpublished_product) { FactoryGirl.build(:product, :unpublished) }

  let(:visible_carousel) { FactoryGirl.build(:carousel, :visible)}
  let(:invisible_carousel) { FactoryGirl.build(:carousel, :invisible)}
  let(:visible_category) { FactoryGirl.build(:category, :visible)}
  let(:invisible_category) { FactoryGirl.build(:category, :invisible)}
  let(:visible_showcase) { FactoryGirl.build(:showcase, :visible)}
  let(:invisible_showcase) { FactoryGirl.build(:showcase, :invisible)}
  let(:visible_quote) { FactoryGirl.build(:quote, :visible)}
  let(:invisible_quote) { FactoryGirl.build(:quote, :invisible)}
  let(:visible_sna) { FactoryGirl.build(:social_network_account, :visible)}
  let(:invisible_sna) { FactoryGirl.build(:social_network_account, :invisible)}


  describe "#publish_status_btn" do
    it "returns different color depending on article's publish status" do
      expect(helper.publish_status_btn(published_article)).to eq("btn-primary")
      expect(helper.publish_status_btn(unpublished_article)).to eq("btn-default")
    end 
    it "returns different color depending on product's publish status" do
      expect(helper.publish_status_btn(published_product)).to eq("btn-primary")
      expect(helper.publish_status_btn(unpublished_product)).to eq("btn-default")
    end
  end

  describe "#publish_status" do
    it "returns article's publish status" do
      expect(helper.publish_status(published_article)).to eq("Published")
      expect(helper.publish_status(unpublished_article)).to eq("Unpublished")
    end  
    it "returns product's publish status" do
      expect(helper.publish_status(published_product)).to eq("Published")
      expect(helper.publish_status(unpublished_product)).to eq("Unpublished")
    end
  end

  describe "#publish_label" do
    it "returns different color depending on article's publish status" do
      expect(helper.publish_label(published_article)).to eq("label-success")
      expect(helper.publish_label(unpublished_article)).to eq("label-default")
    end  

    it "returns different color depending on product's publish status" do
      expect(helper.publish_label(published_product)).to eq("label-success")
      expect(helper.publish_label(unpublished_product)).to eq("label-default")
    end
  end

  describe "#published_thumb?" do
    it "returns 'invisible_thumbnail' for unpublished article" do
      expect(helper.published_thumb?(published_article)).to eq(nil)
      expect(helper.published_thumb?(unpublished_article)).to eq('invisible_thumbnail')
    end

    it "returns 'invisible_thumbnail' for unpublished product" do
      expect(helper.published_thumb?(published_product)).to eq(nil)
      expect(helper.published_thumb?(unpublished_product)).to eq('invisible_thumbnail')
    end
  end

  describe "#visibility_status_btn" do
    it "has different color depending on carousel's visibility" do
      expect(helper.visibility_status_btn(visible_carousel)).to eq("btn-primary")
      expect(helper.visibility_status_btn(invisible_carousel)).to eq("btn-default")
    end  

    it "has different color depending on category's visibility" do
      expect(helper.visibility_status_btn(visible_category)).to eq("btn-primary")
      expect(helper.visibility_status_btn(invisible_category)).to eq("btn-default")
    end
    
    it "has different color depending on showcase's visibility" do
      expect(helper.visibility_status_btn(visible_showcase)).to eq("btn-primary")
      expect(helper.visibility_status_btn(invisible_showcase)).to eq("btn-default")
    end
        
    it "has different color depending on quote's visibility" do
      expect(helper.visibility_status_btn(visible_quote)).to eq("btn-primary")
      expect(helper.visibility_status_btn(invisible_quote)).to eq("btn-default")
    end

    it "has different color depending on SNA's visibility" do
      expect(helper.visibility_status_btn(visible_sna)).to eq("btn-primary")
      expect(helper.visibility_status_btn(invisible_sna)).to eq("btn-default")
    end
  end

  describe "#visibility_status" do
    it "shows carousel's visibility status" do
      expect(helper.visibility_status(visible_carousel)).to eq("Visible")
      expect(helper.visibility_status(invisible_carousel)).to eq("Hidden")
    end  

    it "shows category's visibility status" do
      expect(helper.visibility_status(visible_category)).to eq("Visible")
      expect(helper.visibility_status(invisible_category)).to eq("Hidden")
    end
    
    it "shows showcase's visibility status" do
      expect(helper.visibility_status(visible_showcase)).to eq("Visible")
      expect(helper.visibility_status(invisible_showcase)).to eq("Hidden")
    end
        
    it "shows quote's visibility status" do
      expect(helper.visibility_status(visible_quote)).to eq("Visible")
      expect(helper.visibility_status(invisible_quote)).to eq("Hidden")
    end

    it "shows SNA's visibility status" do
      expect(helper.visibility_status(visible_sna)).to eq("Visible")
      expect(helper.visibility_status(invisible_sna)).to eq("Hidden")
    end
  end
  
  describe "#visibility_label" do
    it "returns different color depending on carousel's visiblility status" do
      expect(helper.visibility_label(visible_carousel)).to eq("label-success")
      expect(helper.visibility_label(invisible_carousel)).to eq("label-default")
    end  

    it "returns different color depending on category's visiblility status" do
      expect(helper.visibility_label(visible_category)).to eq("label-success")
      expect(helper.visibility_label(invisible_category)).to eq("label-default")
    end
    
    it "returns different color depending on showcase's visiblility status" do
      expect(helper.visibility_label(visible_showcase)).to eq("label-success")
      expect(helper.visibility_label(invisible_showcase)).to eq("label-default")
    end
        
    it "returns different color depending on quote's visiblility status" do
      expect(helper.visibility_label(visible_quote)).to eq("label-success")
      expect(helper.visibility_label(invisible_quote)).to eq("label-default")
    end

    it "returns different color depending on SNA's visiblility status" do
      expect(helper.visibility_label(visible_sna)).to eq("label-success")
      expect(helper.visibility_label(invisible_sna)).to eq("label-default")
    end
  end
end
