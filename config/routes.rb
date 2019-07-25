Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"
  devise_for :users, path: '', path_names: {sign_in: 'login', sign_out: 'logout'}

  resources :projects do
    resources :stories
  end
end
