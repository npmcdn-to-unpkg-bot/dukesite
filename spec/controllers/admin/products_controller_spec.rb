require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  let!(:published_product_with_asin_1) { FactoryGirl.create(:published_product_with_asin_1) }
  let!(:unpublished_product_with_asin_3) { FactoryGirl.create(:unpublished_product_with_asin_3) }
  let!(:showcases) { FactoryGirl.create_list(:showcase, 2) }
  let!(:categories) { FactoryGirl.create_list(:category, 2) }
  before { sign_in }

  describe "GET index" do
    it "gets all @products" do
      products = []
      products << published_product_with_asin_1
      products << unpublished_product_with_asin_3

      get :index
      expect(assigns(:products)).to eq( products )
    end
  end

  describe "GET new" do
    it 'assigns a new product to @product' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end

    it 'assigns all @showcases' do
      get :new
      expect(assigns(:all_showcases)).to eq(showcases)
    end
    it 'assigns all @categories' do
      get :new
      expect(assigns(:all_categories)).to eq(categories)
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      subject { post :create, product: FactoryGirl.attributes_for(:unpublished_product_with_asin_4) }

      it "creates a new product" do
        expect{ subject }.to change { Product.count }.by(1)
      end

      it "redirects to products list" do
        expect(subject).to redirect_to admin_products_path
      end
    end

    context "with invalid attributes" do
      subject { post :create, product: FactoryGirl.attributes_for(:invalid_product) }
      
      it "does not save the new product" do
        expect { subject }.to_not change { Product.count }
      end

      it "renders the new template & assigns all_showcases + all_categories" do
        expect(subject).to render_template(:new)
        expect(assigns(:all_showcases)).to eq(showcases)
        expect(assigns(:all_categories)).to eq(categories)
      end
    end
  end

  describe "GET edit" do
    before { get :edit, id: published_product_with_asin_1 }

    it 'assigns @product' do
      expect(assigns(:product)).to eq(published_product_with_asin_1)
    end

    it 'assigns @all_showcases' do
      expect(assigns(:all_showcases)).to eq(showcases)
    end

    it 'assigns @all_categories' do
      expect(assigns(:all_categories)).to eq(categories)
    end
    it 'assigns @keywords' do
      keywords = FactoryGirl.create_list(:keyword, 2)
      published_product_with_asin_1.keywords << keywords
      expect(assigns(:keywords)).to eq(keywords)
    end
  end

  describe "PUT update" do
    context "with valid params" do
      before do
        put :update, 
        id: unpublished_product_with_asin_3, 
        product: FactoryGirl.attributes_for(:unpublished_product_with_asin_4)
      end

      it "redirects to admin_products_path" do
        expect(response).to redirect_to( admin_products_path )
      end
      it "will set flash[:success]" do
        is_expected.to set_flash[:success].to("A product was successfully edited.")
      end
    end

    context "with invalid params" do
      before { put :update, id: unpublished_product_with_asin_3, :product => { asin: ""} }

      it "renders the edit template & assigns all_showcases + all_categories" do
        expect(response).to render_template(:edit)
        expect(assigns(:all_showcases)).to eq(showcases)
        expect(assigns(:all_categories)).to eq(categories)
      end
    end
  end

  describe "DELETE destroy" do
    it "deletes the product" do
      expect{
        delete :destroy, :id => unpublished_product_with_asin_3        
      }.to change(Product,:count).by(-1)
    end
    it "will redirect to admin_products_path" do
      delete :destroy, :id => unpublished_product_with_asin_3
      expect(response).to redirect_to admin_products_path
    end  
    it "will set flash[:success]" do
      delete :destroy, :id => unpublished_product_with_asin_3
      expect(flash[:success]).to eq("A product was successfully deleted.")
    end
  end
  describe "PUT publish_switch" do
    context "to publish a product" do
      before do
        put :publish_switch, id: unpublished_product_with_asin_3, published: true
        unpublished_product_with_asin_3.reload
      end 
      it "publishes product" do
        expect(unpublished_product_with_asin_3.published).to be_truthy
      end
      it "will set flash[:success]" do
        expect(flash[:success]).to eq("Successfully updated.")
      end
      it "responses with JSON" do
        res = {response: "", product_status: true}.to_json
        expect(response.body).to eq(res)
      end
    end
    context "unpublish a product" do
      before do
        get :publish_switch, id: published_product_with_asin_1, published: false
        published_product_with_asin_1.reload
      end 
      it "publishes product" do
        expect(published_product_with_asin_1.published).to be_falsy
      end
      it "will set flash[:success]" do
        expect(flash[:success]).to eq("Successfully updated.")
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "responses with JSON" do
        res = {response: "", product_status: false}.to_json
        expect(response.body).to eq(res)
      end
    end
    context "with invalid params" do
      before { get :publish_switch, id: published_product_with_asin_1, published: "test" }
      it "has a 400 status code" do
        expect(response.status).to eq(400)
      end
      it "responses with JSON" do
        res = {response: "Please try again", product_status: nil}.to_json
        expect(response.body).to eq(res)
      end
    end
  end
  describe "PUT lookup_item_on_amazon" do
    include ProductHelpers
    context "with invalid params" do
      before { get :lookup_item_on_amazon, asin: "" }
      it "has a 400 status code" do
        expect(response.status).to eq(400)
      end
      it "responses with JSON" do
        res = {response: "Please enter ASIN", data: nil}.to_json
        expect(response.body).to eq(res)
      end
    end
    context "with valid params" do
      before do
        @asin = "B01BY3PEUM"
        get :lookup_item_on_amazon, asin: @asin
      end
      it "has a 200 status code" do
        expect(response.status).to eq(200)
      end
      it "responses with JSON" do
        res = {response: res_text(@asin), data: return_items(@asin) }.to_json
        expect(response.body).to eq(res)
      end
    end
  end
end
