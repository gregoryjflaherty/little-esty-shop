Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do
    resources :items, controller: 'merchant_items'
  end
  get 'merchants/:merchant_id/dashboard', to: 'merchants#dashboard'

  get '/merchants/:merchant_id/invoices',to: 'merchant_invoices#index'
  get 'merchants/:merchant_id/invoices/invoice_id', to: 'merchant_invoices#show'
end
