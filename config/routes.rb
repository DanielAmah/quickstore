Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :categories do  
    resources :products
  end
  
  resources :order_status_codes do
    resources :orders
  end

  resources :order_item_status_codes
end
