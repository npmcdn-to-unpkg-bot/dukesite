Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :admins do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :admin, only: [:index]
  
  namespace "admin" do
    resources :products, execpt: [:show]
    resources :showcases, execpt: [:show, :new]
    resources :categories, execpt: [:show, :new, :edit]
    resources :social_network_accounts, except: [:show]
    resources :quotes, execpt: [:new, :show]
    resources :carousels, execpt: [:new]
    resources :site_configs, :only:[:index, :update]
    ## Show a list of those products under a category/showcase 
    get '/categories/:id/list', to: 'categories#product_list', as: 'category_products'
    get '/showcases/:id/list', to: 'showcases#product_list', as: 'showcase_products'
    ## Look up product via Amazon API
    get '/look_up_item', to: 'products#lookup_item_on_amazon'
    ## Visible/Publish Switch
    put '/products/:id/publish_product', to: 'products#publish_switch', as: 'product_publish_switch'
    put '/categories/:id/category_visible', to: 'categories#visible_switch', as: 'category_visible_switch' 
    put '/showcases/:id/showcase_visible', to: 'showcases#visible_switch', as: 'showcase_visible_switch'
    put '/quotes/:id/quote_visible', to: 'quotes#visible_switch', as: 'quote_visible_switch'
  end
  resources :products, only: [:show]
  resources :showcases, only: [:show]
  resources :categories, only: [:show]
  get '/our-story', to: 'welcome#our_story', as: 'story'
  get '/join-us', to: 'welcome#join_us', as: 'join_us'
  put '/subscriber', to: 'application#create_subscriber', as: 'create_subscriber'
end
