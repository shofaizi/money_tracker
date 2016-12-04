Rails.application.routes.draw do

  root 'home#index'
  resources :home, only: [:new, :create, :destroy]
  post 'contact_submit' => 'users#contact_submit'


  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :budgets
  resources :users, only: [:new, :create, :update, :edit]
  resources :spendings
  resources :transactions, only: [:show, :index]
  get '/overview' => 'transactions#overview', as: :overview



end


# index create new edit update
