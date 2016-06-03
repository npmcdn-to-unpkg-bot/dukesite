require 'rails_helper'

RSpec.describe BlogController, type: :controller do
  describe "Get index" do
    it "gets @published_articles" do
      published_articles = FactoryGirl.create_list(:article, 3, published: true, published_at: Time.now)
      FactoryGirl.create_list(:article, 2, published: false)

      get :index
      expect(assigns(:articles)).to eq( published_articles )
    end
  end

  describe "Get show" do
    it "gets @published_article" do
      published_article = FactoryGirl.create(:article, published: true, published_at: Time.now)
      
      get :show, id: published_article
      expect(assigns(:article)).to eq( published_article )
    end
  end
end
