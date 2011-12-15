RailsApp::Application.routes.draw do

  resources :posts do
    resources :comments
  end

  match '/home' => 'home#index'

  root :to => 'base#index'

end
