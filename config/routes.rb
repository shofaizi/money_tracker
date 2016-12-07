Rails.application.routes.draw do

  root 'home#index'
  post 'contact_submit' => 'users#contact_submit'


  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :budgets
  resources :users, only: [:new, :create, :update, :edit]
  resources :transactions
  get '/overview' => 'transactions#overview', as: :overview
  get '/new_credit' => 'transactions#new_credit', as: :new_credit
  get '/new_debit' => 'transactions#new_debit', as: :new_debit
  get '/spending_index' => 'transactions#spending_index', as: :spending_index


end
