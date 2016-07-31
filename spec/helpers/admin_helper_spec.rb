require 'rails_helper'

describe AdminHelper do
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
    context "when the article is published" do
      it "returns 'btn-primary'" do
        expect(helper.publish_status_btn(published_article)).to eq("btn-primary")
      end
    end

    context "when the article is not published" do
      it "returns 'btn-default'" do
        expect(helper.publish_status_btn(unpublished_article)).to eq("btn-default")
      end
    end  

    context "when the product is published" do
      it "returns 'btn-primary'" do
        expect(helper.publish_status_btn(published_product)).to eq("btn-primary")
      end
    end

    context "when the product is not published" do
      it "returns 'btn-default'" do
        expect(helper.publish_status_btn(unpublished_product)).to eq("btn-default")
      end
    end
  end

  describe "#publish_status" do
    context "when the article is published" do
      it "returns 'Published'" do
        expect(helper.publish_status(published_article)).to eq("Published")
      end
    end

    context "when the article is not published" do
      it "returns 'Unpublished'" do
        expect(helper.publish_status(unpublished_article)).to eq("Unpublished")
      end
    end  

    context "when the product is published" do
      it "returns 'Published'" do
        expect(helper.publish_status(published_product)).to eq("Published")
      end
    end

    context "when the product is not published" do
      it "returns 'Unpublished'" do
        expect(helper.publish_status(unpublished_product)).to eq("Unpublished")
      end
    end
  end

  describe "#publish_label" do
    context "when the article is published" do
      it "returns 'label-success'" do
        expect(helper.publish_label(published_article)).to eq("label-success")
      end
    end

    context "when the article is not published" do
      it "returns 'label-default'" do
        expect(helper.publish_label(unpublished_article)).to eq("label-default")
      end
    end  

    context "when the product is published" do
      it "returns 'label-success'" do
        expect(helper.publish_label(published_product)).to eq("label-success")
      end
    end

    context "when the product is not published" do
      it "returns 'label-default'" do
        expect(helper.publish_label(unpublished_product)).to eq("label-default")
      end
    end
  end

  describe "#published_thumb?" do
    context "when the article is not published" do
      it "returns 'invisible_thumbnail'" do
        expect(helper.published_thumb?(unpublished_article)).to eq('invisible_thumbnail')
      end
    end
    
    context "when the article is published" do
      it "returns nil" do
        expect(helper.published_thumb?(published_article)).to eq(nil)
      end
    end

    context "when the product is not published" do
      it "returns 'invisible_thumbnail'" do
        expect(helper.published_thumb?(unpublished_product)).to eq('invisible_thumbnail')
      end
    end
    
    context "when the product is published" do
      it "returns nil" do
        expect(helper.published_thumb?(published_product)).to eq(nil)
      end
    end
  end

  describe "#visibility_status_btn" do
    context "when the carousel is visible" do
      it "returns 'btn-primary'" do
        expect(helper.visibility_status_btn(visible_carousel)).to eq("btn-primary")
      end
    end

    context "when the carousel is invisible" do
      it "returns 'btn-default'" do
        expect(helper.visibility_status_btn(invisible_carousel)).to eq("btn-default")
      end
    end  

    context "when the category is visible" do
      it "returns 'btn-primary'" do
        expect(helper.visibility_status_btn(visible_category)).to eq("btn-primary")
      end
    end

    context "when the category is invisible" do
      it "returns 'btn-default'" do
        expect(helper.visibility_status_btn(invisible_category)).to eq("btn-default")
      end
    end
    
    context "when the showcase is visible" do
      it "returns 'btn-primary'" do
        expect(helper.visibility_status_btn(visible_showcase)).to eq("btn-primary")
      end
    end

    context "when the showcase is invisible" do
      it "returns 'btn-default'" do
        expect(helper.visibility_status_btn(invisible_showcase)).to eq("btn-default")
      end
    end
        
    context "when the quote is visible" do
      it "returns 'btn-primary'" do
        expect(helper.visibility_status_btn(visible_quote)).to eq("btn-primary")
      end
    end

    context "when the quote is invisible" do
      it "returns 'btn-default'" do
        expect(helper.visibility_status_btn(invisible_quote)).to eq("btn-default")
      end
    end

    context "when the social_network_account is visible" do
      it "returns 'btn-primary'" do
        expect(helper.visibility_status_btn(visible_sna)).to eq("btn-primary")
      end
    end

    context "when the social_network_account is invisible" do
      it "returns 'btn-default'" do
        expect(helper.visibility_status_btn(invisible_sna)).to eq("btn-default")
      end
    end
  end

  describe "#visibility_status" do
    context "when the carousel is visible" do
      it "returns 'Visible'" do
        expect(helper.visibility_status(visible_carousel)).to eq("Visible")
      end
    end

    context "when the carousel is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_status(invisible_carousel)).to eq("Hidden")
      end
    end  

    context "when the category is visible" do
      it "returns 'Visible'" do
        expect(helper.visibility_status(visible_category)).to eq("Visible")
      end
    end

    context "when the category is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_status(invisible_category)).to eq("Hidden")
      end
    end
    
    context "when the showcase is visible" do
      it "returns 'Visible" do
        expect(helper.visibility_status(visible_showcase)).to eq("Visible")
      end
    end

    context "when the showcase is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_status(invisible_showcase)).to eq("Hidden")
      end
    end
        
    context "when the quote is visible" do
      it "returns 'Visible'" do
        expect(helper.visibility_status(visible_quote)).to eq("Visible")
      end
    end

    context "when the quote is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_status(invisible_quote)).to eq("Hidden")
      end
    end

    context "when the social_network_account is visible" do
      it "returns 'Visible'" do
        expect(helper.visibility_status(visible_sna)).to eq("Visible")
      end
    end

    context "when the social_network_account is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_status(invisible_sna)).to eq("Hidden")
      end
    end
  end
  
  describe "#visibility_label" do
    context "when the carousel is visible" do
      it "returns 'Visible'" do
        expect(helper.visibility_label(visible_carousel)).to eq("label-success")
      end
    end

    context "when the carousel is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_label(invisible_carousel)).to eq("label-default")
      end
    end  

    context "when the category is visible" do
      it "returns 'Visible'" do
        expect(helper.visibility_label(visible_category)).to eq("label-success")
      end
    end

    context "when the category is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_label(invisible_category)).to eq("label-default")
      end
    end
    
    context "when the showcase is visible" do
      it "returns 'Visible" do
        expect(helper.visibility_label(visible_showcase)).to eq("label-success")
      end
    end

    context "when the showcase is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_label(invisible_showcase)).to eq("label-default")
      end
    end
        
    context "when the quote is visible" do
      it "returns 'Visible'" do
        expect(helper.visibility_label(visible_quote)).to eq("label-success")
      end
    end

    context "when the quote is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_label(invisible_quote)).to eq("label-default")
      end
    end

    context "when the social_network_account is visible" do
      it "returns 'Visible'" do
        expect(helper.visibility_label(visible_sna)).to eq("label-success")
      end
    end

    context "when the social_network_account is invisible" do
      it "returns 'Hidden'" do
        expect(helper.visibility_label(invisible_sna)).to eq("label-default")
      end
    end
  end
end

