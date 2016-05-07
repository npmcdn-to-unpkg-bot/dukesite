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
    resources :quotes
    ## Show a list of those products under a category/showcase 
    get '/categories/:id/list', to: 'categories#product_list', as: 'category_products'
    get '/showcases/:id/list', to: 'showcases#product_list', as: 'showcase_products'
    ## Look up product via Amazon API
    get '/look_up_item', to: 'products#lookup_item_on_amazon'
    ## Visible/Publish Switch
    put '/products/:id/publish_product', to: 'products#publish_switch', as: 'product_publish_switch'
    put '/categories/:id/category_visible', to: 'categories#visible_switch', as: 'category_visible_switch' 
    put '/showcases/:id/showcase_visible', to: 'showcases#visible_switch', as: 'showcase_visible_switch'    
  end
  resources :products, only: [:show]
  resources :showcases, only: [:show]
  resources :categories, only: [:show]
  get '/our-story', to: 'welcome#our_story', as: 'story'
  put '/subscriber', to: 'application#create_subscriber', as: 'create_subscriber'
end
