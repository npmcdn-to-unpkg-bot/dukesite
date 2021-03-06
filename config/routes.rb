Rails.application.routes.draw do
  root 'welcome#index'

  devise_for :admin do
    get '/admin/sign_out' => 'devise/sessions#destroy'
  end

  resources :admin, only: [:index]
  
  namespace "admin" do
    resources :products, except: [:show] do
      resources :keywords, only: [:create]
    end
    resources :showcases, except: [:new, :edit] do
      resources :keywords, only: [:create]
      put :update_image, as: 'update_image'
    end
    resources :categories, except: [:new, :edit] do
      resources :keywords, only: [:create]
      put :update_image, as: 'update_image'
    end
    resources :social_network_accounts, except: [:show] do
      put :update_image, as: 'update_image'
    end
    resources :quotes, except: [:new, :show] do
      put :update_image, as: 'update_image'
    end
    resources :carousels, except: [:new, :show] do
      put :update_image, as: 'update_image'
    end
    resources :site_configs, only:[:index, :update, :edit] do
      resources :keywords, only: [:create]
    end
    resources :keywords, only: [:destroy]
    # Newsletters
    # ------------------------------------------------------------------------------
    resources :newsletters, except: [:show] do
      put :send_newsletter
    end
    # Blog in Dashboard
    # ------------------------------------------------------------------------------
    resources :blog, only: [:index]
    namespace "blog" do
      resources :articles
      put '/:id/publish_article', to: 'articles#publish_switch', as: 'article_publish_switch'
    end

    # Site configurations
    # ------------------------------------------------------------------------------
    put '/site_configs/update', to: 'site_configs#update', as: 'general_site_configs'
    
    # Look up product via Amazon API
    # ------------------------------------------------------------------------------
    put '/look_up_item', to: 'products#lookup_item_on_amazon'
    # Update products attributes via Amazon API
    # ------------------------------------------------------------------------------
    put '/update_imgs', to: 'products#update_imgs', as: 'update_imgs_via_amazon'
    
    # Visible/Publish Switch
    # ------------------------------------------------------------------------------
    put '/products/:id/publish_product', to: 'products#publish_switch', as: 'product_publish_switch'
    put '/categories/:id/category_visible', to: 'categories#visible_switch', as: 'category_visible_switch' 
    put '/showcases/:id/showcase_visible', to: 'showcases#visible_switch', as: 'showcase_visible_switch'
    put '/quotes/:id/quote_visible', to: 'quotes#visible_switch', as: 'quote_visible_switch'
    put '/carousels/:id/carousel_visible', to: 'carousels#visible_switch', as: 'carousel_visible_switch'
  end

  resources :products, only: [:show]
  resources :showcases, only: [:show]
  resources :categories, only: [:show]

  # Blog Routes
  # ------------------------------------------------------------------------------
  resources :blog, only: [:index, :show]

  # Others
  # ------------------------------------------------------------------------------
  get '/our-story', to: 'welcome#our_story', as: 'story'
  get '/join-us', to: 'welcome#join_us', as: 'join_us'

  ## Subscriber Newsletter
  put '/subscribe_newsletter', to: 'subscribers#create'
  get '/subscribe_newsletter/confirm_email/:id', to: 'subscribers#confirm_email', as: 'newsletter_confirm_email'
  
  # error page
  # ------------------------------------------------------------------------------
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end
