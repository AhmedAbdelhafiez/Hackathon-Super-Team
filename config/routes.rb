Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users
  resources :questions
  
  # Users
  get '/api/users', to: 'users#index'
  get '/api/user', to: 'users#new'
  get '/api/current_user', to: 'users#current_user'
  post '/api/user', to: 'users#create'
  delete '/api/user', to: 'users#delete'
  
  # Questions
  get '/api/question', to: 'chatbot#get_question'
  post '/api/question', to: 'chatbot#post_question'
  get '/api/answer', to: 'chatbot#get_answer'
  post '/api/answer', to: 'chatbot#post_answer'
  post '/api/new_user', to: 'chatbot#new_user'

  # Reports
  get '/api/user_report', to: 'chatbot#user_report'
  
end
