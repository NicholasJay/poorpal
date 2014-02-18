Poorpal::Application.routes.draw do
  resources :users do 
    resources :shopping_lists do
      resources :products 
      
    end
  end

  get '/session', to: 'session#new'
  post '/session', to: 'session#create'
  delete '/session', to: 'session#destroy'

  get '/'

  root 'welcome#index'
end
