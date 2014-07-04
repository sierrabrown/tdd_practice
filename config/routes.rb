Rails.application.routes.draw do
  resources :users
  resources :goals do
    collection do
      get :completed
      get :incomplete
    end
  end
  resource :session
end
