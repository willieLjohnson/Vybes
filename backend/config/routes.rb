Rails.application.routes.draw do
  resources :users do
    collection do 
      get "/login", to: "users#login"
    end
  end
  resources :entries
end
