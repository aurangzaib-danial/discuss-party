Rails.application.routes.draw do
  devise_for :users
  
  root 'site#home'
  get 'about', to: 'site#about'
  get 'search', to: 'site#search'

  resources :topics, only: %i[new create update] do
    resources :comments, only: :create
    member do
      patch 'vote'
    end
    resources :viewers, only: :create
  end

  scope ':id/:slug', controller: :topics do
    root action: 'show', as: :topic_slug
    get 'edit', as: :edit_topic
    get 'sharing', as: :sharing_topic
  end


  get 'private', to: 'users#private'
  get 'shared-with-me', to: 'users#shared_with_me'
  get 'users/:id/:slug', to: 'users#profile', as: :user_slug

  get ':slug', to: 'tags#show', as: :tag_slug
end
