require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  describe "Get show" do
    it "gets @published_products under @category" do
      category = FactoryGirl.create(:category, visible: true)
      category_published_products = category.products.where(published: true)
      get :show, id: category
      expect(assigns(:products)).to eq( category_published_products)
    end 
  end
end
