Rails.application.routes.draw do
  devise_for :users
  root 'chats#index'
  resources :chat_groups, only: [:new, :create, :edit, :update, :index] do
    resources :chats, only: [:create, :index]
  end
end
