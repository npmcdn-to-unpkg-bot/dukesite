Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :admins do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :admin, only: [:index]
  
  namespace "admin" do
    resources :products, execpt: [:show]
    resources :showcases, execpt: [:show]
    resources :categories, execpt: [:show]
    resources :social_network_accounts
    get '/categories/:id/list', to: 'categories#product_list', as: 'category_products'
    get '/showcases/:id/list', to: 'showcases#product_list', as: 'showcase_products'
  end

  get '/products/:id', to: 'admin/products#show', as: 'product'
  get '/showcases/:id', to: 'admin/showcases#show', as: 'showcase'
  get '/categories/:id', to: 'admin/categories#show', as: 'category'
  get '/our-story', to: 'welcome#our_story', as: 'story'
  put '/subscriber', to: 'application#create_subscriber'
end
