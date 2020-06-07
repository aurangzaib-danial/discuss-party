Rails.application.routes.draw do
  root 'site#home'
  get 'about', to: 'site#about'
end
