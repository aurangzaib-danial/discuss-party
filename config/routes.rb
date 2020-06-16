Rails.application.routes.draw do
  root 'site#home'
  get 'about', to: 'site#about'
  devise_for :users
  
  resources :topics, only: %i[new create] do
    resource :comments, only: :create
  end
  
  get ':slug/:id', to: 'topics#show', as: :topic_slug
  get ':slug', to: 'tags#show', as: :tag_slug

  get 'search', to: 'site#search'
end
