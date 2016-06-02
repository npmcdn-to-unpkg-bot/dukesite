require 'rails_helper'

RSpec.describe ShowcasesController, type: :controller do
  describe "Get show" do
    it "gets @published_products under @showcase" do
      showcase = FactoryGirl.create(:showcase, visible: true)
      showcase_published_products = showcase.products.where(published: true)
      
      get :show, id: showcase
      expect(assigns(:products)).to eq( showcase_published_products)
    end 
  end

end
