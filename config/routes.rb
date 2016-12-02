Rails.application.routes.draw do

  root 'home#index'
  post '/contact_submit' => 'users#contact_submit'

  resources :budgets
  resources :transactions
  resources :spendings
  resources :sessions, only: [:new, :create, :destroy] do
    delete :destroy, on: :collection
  end
  resources :users, only: [:new, :create, :update, :edit]
end
