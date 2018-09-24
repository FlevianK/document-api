Rails.application.routes.draw do
  resources :documents
  
  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

end
