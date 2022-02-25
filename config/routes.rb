Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do

    resources :invoices, controller: 'merchant_invoices'

    resources :items, controller: 'merchant_items', except: [:destroy]

    resources :dashboard, controller: 'merchant_dashboard', only: [:index]
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end
