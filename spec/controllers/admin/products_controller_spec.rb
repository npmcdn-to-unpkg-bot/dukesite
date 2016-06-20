require 'rails_helper'
require 'admin/products_controller'

RSpec.describe Admin::ProductsController, type: :controller do
  let(:admin) { FactoryGirl.create(:admin) }
  before :each do
    sign_in admin
  end

  describe "Get index" do
    it "gets all @products" do
      products = []
      products << FactoryGirl.create(:published_product_with_asin_1)
      products << FactoryGirl.create(:published_product_with_asin_2)

      get :index
      expect(assigns(:products)).to eq( products )
    end
  end

  describe "Get new" do
    it 'assigns a new product to @product' do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end

    it 'assigns all @showcases' do
      showcases = FactoryGirl.create_list(:showcase, 2)
      get :new
      expect(assigns(:all_showcases)).to eq(showcases)
    end
    it 'assigns all @categories' do
      categories = FactoryGirl.create_list(:category, 2)
      get :new
      expect(assigns(:all_categories)).to eq(categories)
    end
  end

  describe "Post create" do
    context "with valid attributes" do
      subject { post :create, product: FactoryGirl.attributes_for(:published_product_with_asin_1) }

      it "creates a new product" do
        expect{ subject }.to change { Product.count }.by(1)
      end

      it "redirects to products list" do
        expect(subject).to redirect_to admin_products_path
      end
    end

    context "without valid attributes" do
      subject { post :create, product: FactoryGirl.attributes_for(:invalid_product) }
      
      it "does not save the new product" do
        expect { subject }.to_not change { Product.count }
      end

      it "renders the :new" do
        expect(subject).to render_template(:new)
      end
    end
  end

  describe "Get edit" do
    let(:product) { FactoryGirl.create(:published_product_with_asin_1) }

    before(:each) do
      get :edit, id: product
    end
    it 'finds a specific @product' do
      expect(assigns(:product)).to eq(product)
    end

    it 'assigns all @showcases' do
      showcases = FactoryGirl.create_list(:showcase, 2)
      get :new
      expect(assigns(:all_showcases)).to eq(showcases)
    end

    it 'assigns all @categories' do
      categories = FactoryGirl.create_list(:category, 2)
      get :new
      expect(assigns(:all_categories)).to eq(categories)
    end
    it 'assigns all the keywords of a specific @product' do
      keywords = FactoryGirl.create_list(:keyword, 2)
      product.keywords = keywords
      expect(assigns(:keywords)).to eq(product.keywords)
    end
  end

  describe "Put update" do
    let(:product) { FactoryGirl.create(:published_product_with_asin_1) }
    context "with valid attributes" do
      let(:attr) do
        { :asin        => 'B00VQKC86W', 
          :title       => Faker::Name.title,
          :description => 'new description',
          :url         => Faker::Internet.url('example.com'),
          :image_url   => Faker::Avatar.image }
      end
      before(:each) do
        put :update, id: product, :product => attr
        product.reload
      end
      it { product.asin.should eq attr[:asin] }
      it { product.title.should eq attr[:title] }
      it { product.description.should eq attr[:description] }
      it { product.url.should eq attr[:url] }
      it { product.image_url.should eq attr[:image_url] }
      it { response.should redirect_to admin_products_path }
    end

    context "without valid attributes" do
      let(:attr) do
        { :asin        => nil, 
          :title       => nil,
          :url         => nil,
          :image_url   => nil }
      end

      subject {
        put :update, id: product, :product => attr
        product.reload
      }

      it "does not save the new product" do
        subject
        expect(product.asin).to_not eq attr[:asin]
        expect(product.title).to_not eq attr[:title]
        expect(product.url).to_not eq attr[:url]
        expect(product.image_url).to_not eq attr[:image_url]
      end

      it "renders the :edit" do
        expect(subject).to render_template(:edit)
      end

    end
  end
  describe "Put publish_switch" do
    
  end
end
