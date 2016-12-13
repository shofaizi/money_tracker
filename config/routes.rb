Rails.application.routes.draw do

  get 'balance/index'
  root 'home#index'
  post 'contact_submit' => 'users#contact_submit'
  get "/auth/twitter", as: :sign_in_with_twitter
  get "/auth/twitter/callback" => "callbacks#twitter"
  get '/overview' => 'transactions#overview', as: :overview
  get '/new_credit' => 'transactions#new_credit', as: :new_credit
  get '/new_debit' => 'transactions#new_debit', as: :new_debit
  get '/spending_index' => 'transactions#spending_index', as: :spending_index
  get '/overview/ajax' => 'transactions#overview_ajax'

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end

  resources :balances, only: [:index]
  resources :budgets
  resources :users, only: [:new, :create, :update, :edit]
  resources :transactions
end
