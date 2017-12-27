Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :categories  do  
    resources :products do
      resources :order_items
    end
  end
  
  resources :order_status_codes do
    resources :orders do
      resources :invoices
      resources :order_items
    end
  end

  resources :order_item_status_codes do
    resources :order_items
  end

  resources :invoice_status_codes do
    resources :invoices
  end
end
