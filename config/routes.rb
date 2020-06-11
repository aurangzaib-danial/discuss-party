Rails.application.routes.draw do
  root 'site#home'
  get 'about', to: 'site#about'
  devise_for :users
  
  resources :topics, only: %i[new create]
  get ':slug/:id', to: 'topics#show', as: :topic_slug
end
