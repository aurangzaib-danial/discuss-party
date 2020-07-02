Rails.application.routes.draw do
  devise_for :users
  
  root 'site#home'
  get 'about', to: 'site#about'
  get 'search', to: 'site#search'

  resources :topics, only: %i[new create update] do
    resources :comments, only: :create
    patch 'vote', on: :member
  end

  get ':id/:slug', to: 'topics#show', as: :topic_slug
  get ':id/:slug/edit', to: 'topics#edit', as: :edit_topic

  get 'private', to: 'users#private'
  get 'users/:id/:slug', to: 'users#profile', as: :user_slug

  get ':slug', to: 'tags#show', as: :tag_slug
end
