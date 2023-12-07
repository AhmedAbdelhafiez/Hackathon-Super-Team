Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users
  resources :questions
  
  # Users
  get '/api/users', to: 'users#index'
  get '/api/user', to: 'users#get_user'
  get '/api/current_user', to: 'users#current_user'
  post '/api/user', to: 'users#create'
  post '/api/dummy_user', to: 'users#dummy_user'
  delete '/api/user', to: 'users#delete'
  
  # Questions
  get '/api/question', to: 'api#get_question'
  post '/api/question', to: 'api#post_question'
  get '/api/answer', to: 'api#get_answer'
  post '/api/answer', to: 'api#post_answer'
  
  # Reports
  get '/api/system_report', to: 'api#system_report'
  get '/api/user_report', to: 'api#user_report'
  
end
