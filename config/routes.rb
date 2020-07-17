Rails.application.routes.draw do
  root 'site#home'
  get 'search', to: 'site#search'
  
  namespace :manage do
    resources :tags, except: :show
    resources :moderators, only: %i[index new create destroy]
    resources :users, only: %i[index new create destroy]
    resources :topics, only: :index
  end

  devise_for(:users, 
    controllers: { registrations: 'registrations',  
      omniauth_callbacks: 'omniauth_callbacks' }
  )

  resources :topics, only: %i[new create update destroy] do
    resources :comments, only: :create
    member do
      patch 'vote'
    end
    resources :viewers, only: %i[create destroy]
    resources :reports, only: :create
  end

  resources :comments, only: :destroy

  scope ':id/:slug', controller: :topics do
    root action: 'show', as: :topic_slug
    get 'edit', as: :edit_topic
    get 'sharing', as: :sharing_topic
  end

  scope '/', controller: 'users' do
    get 'private'
    get 'shared-with-me'
  end 

  get 'users/:id/:slug', to: 'users#profile', as: :user_slug

  get ':id', to: 'tags#show', as: :tag
end
