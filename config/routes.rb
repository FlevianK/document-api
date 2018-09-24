Rails.application.routes.draw do
  resources :documents do
    resources :reviews
  end
  
  post 'login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'

end
