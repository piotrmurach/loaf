RailsApp::Application.routes.draw do

  root :to => 'home#index'

  resources :posts do
    resources :comments
  end

end
