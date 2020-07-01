Rails.application.routes.draw do
  root 'site#home'
  get 'about', to: 'site#about'
  devise_for :users
  
  resources :topics, only: %i[new create update] do
    resources :comments, only: :create
    patch 'vote', on: :member
  end

  get 'search', to: 'site#search'
  
  get ':id/:slug', to: 'topics#show', as: :topic_slug
  get ':id/:slug/edit', to: 'topics#edit', as: :edit_topic

  get ':slug', to: 'tags#show', as: :tag_slug

  get 'users/:id/:slug', to: 'users#profile', as: :user_slug
end
