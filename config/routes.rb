Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
   # 追加
   namespace :api do
    namespace :v1 do
      resources :users, only:[:index]
    end
  end
end
