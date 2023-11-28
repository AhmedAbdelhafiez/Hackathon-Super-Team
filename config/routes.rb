Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :questions, only: [:index, :create]
  resources :users
  resources :questions
  
  get '/api/question', to: 'chatbot#get_question'
  post '/api/question', to: 'chatbot#send_question'
  get '/api/answer', to: 'chatbot#get_answer'
  
  
end
