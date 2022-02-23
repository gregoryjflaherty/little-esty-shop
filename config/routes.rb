Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do

    resources :items, controller: 'merchant_items', only: [:index, :show]
    resources :dashboard, controller: 'merchant_dashboard', only: [:index]
    resources :invoices, controller: 'merchant_invoices', only: [:index]
  end
end
