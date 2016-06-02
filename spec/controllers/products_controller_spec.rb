require 'rails_helper'
require 'products_controller'

RSpec.describe ProductsController, type: :controller do
  describe "GET show" do
    let(:product) { FactoryGirl.create( :product, published: true) }
    it "gets the @price of @product" do
      get :show, id: product
        price = Amazon::EcsWrapper.get_item_price(product.asin)
        expect(assigns(:price)).to eq( price )
    end
  end
end
