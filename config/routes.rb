Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'
  resources :chat_groups, only: [:new, :create, :edit, :update] do
    resources :chats, only: [:create, :index]
    collection do
      get 'search'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
