require 'api_constraints'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :categories  do  
        resources :products do
          resources :order_items
        end
      end
      
      resources :order_status_codes do
        resources :orders do
          resources :shipments
          resources :invoices do
            resources :payments
          end
          resources :order_items do
            resources :shipment_items
          end
        end
      end

      resources :order_item_status_codes do
        resources :order_items
      end

      resources :invoice_status_codes do
        resources :invoices do
          resources :shipments do
            resources :shipment_items
          end
        end
      end

      resources :payment_methods

      resources :roles
      resources :users do
        collection do 
          get 'search/:q', :action => 'search', :as => 'search'
        end
      end
      get 'test', to: 'users#test'
      match '/(*url)', to: 'not_found#index', via: :all
    end
  end

  post 'auth/register', to: 'authenticate#register'
  post 'auth/login', to: 'authenticate#login'
end
