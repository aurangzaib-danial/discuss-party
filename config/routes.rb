Rails.application.routes.draw do
  root 'site#home'
  get 'about', to: 'site#about'
  devise_for :users
  
  resources :topics, only: %i[new create] do
    resource :comments, only: :create
  end
  get ':slug/:id', to: 'topics#show', as: :topic_slug
end
