require 'rails_helper'

describe BlogHelper do
  describe "#create_time" do
    context "when an article is created" do
      it "returns formated create time" do
        saved_article = FactoryGirl.create(:article)
        create_time = saved_article.created_at.to_formatted_s(:long)

        expect(helper.article_create_time(saved_article)).to eq(create_time)
      end
    end
    context "when an article is not created" do
      it "returns 'Not Saved Yet" do
        not_saved_article = FactoryGirl.build(:article)
        expect(helper.article_create_time(not_saved_article)).to eq('Not Saved Yet')
      end
    end
  end

  describe "#create_time" do
    context "when an article is created" do
      it "returns formated create time" do
        saved_article = FactoryGirl.create(:article)
        create_time = saved_article.created_at.to_formatted_s(:long)

        expect(helper.article_create_time(saved_article)).to eq(create_time)
      end
    end
    context "when an article is not created" do
      it "returns 'Not Saved Yet" do
        not_saved_article = FactoryGirl.build(:article)
        expect(helper.article_create_time(not_saved_article)).to eq('Not Saved Yet')
      end
    end
  end
end
