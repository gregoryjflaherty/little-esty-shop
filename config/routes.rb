Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do

    resources :items, controller: 'merchant_items', only: [:index, :show]
    resources :dashboard, controller: 'merchant_dashboard', only: [:index]
    resources :invoices, controller: 'merchant_invoices', only: [:index]
  end

  get '/merchants/:merchant_id/invoices',to: 'merchant_invoices#index'
  patch 'merchants/:merchant_id/:item_id/update', to: 'merchant_items#update'
  get 'merchants/:merchant_id/:item_id', to: 'merchant_items#show'


  #get 'merchants/:merchant_id/dashboard', to: 'dashboard#show'

  #get 'merchants/:merchant_id/invoices/invoice_id', to: 'merchant_invoices#show'
end
