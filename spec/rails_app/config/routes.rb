RailsApp::Application.routes.draw do
  root :to => "home#index"

  resources :posts do
    resources :comments
  end

  get "/onboard", to: "onboard#setup", as: :onboard
  get "/onboard/step/:step", to: "onboard#setup", as: :onboard_step
  post "/onboard/step/:step", to: "onboard#setup"
  patch "/onboard/step/:step", to: "onboard#setup"
  put "/onboard/step/:step", to: "onboard#setup"
  delete "/onboard/step/:step", to: "onboard#setup"
end
