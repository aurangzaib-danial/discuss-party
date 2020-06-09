Rails.application.routes.draw do
  root 'site#home'
  get 'about', to: 'site#about'
  devise_for :users
  
  resources :topics, only: %i[new show create]
end
