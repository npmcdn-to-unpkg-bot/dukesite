require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET index" do
    it "gets @visible_carousels" do
      visible_carousels = FactoryGirl.create_list(:carousel, 2, visible: true)
      get :index
      expect(assigns(:visible_carousels)).to eq( visible_carousels )
    end
  end

  describe "GET our_story" do
    let(:our_story) { FactoryGirl.create(:site_config, key: "Our Story") }

    it "gets @our_story" do
      get :our_story, id: our_story
      expect(assigns(:our_story)).to eq( our_story.value )
    end
  end

  describe "GET join_us" do
    let(:join_us) { FactoryGirl.create(:site_config, key: "Join Us") }

    it "gets @join_us" do
      get :join_us, id: join_us
      expect(assigns(:join_us)).to eq( join_us.value )
    end
  end
end
