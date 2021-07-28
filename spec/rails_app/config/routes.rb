RailsApp::Application.routes.draw do
  root to: "home#index"

  resources :posts do
    resources :comments
  end

  get "/onboard", to: "onboard#setup", as: :onboard
  get "/onboard/step/:step", to: "onboard#setup", as: :onboard_step
  post "/onboard/step/:step", to: "onboard#setup"
  if Rails.version >= "4.0.0"
    patch "/onboard/step/:step", to: "onboard#setup"
  end
  put "/onboard/step/:step", to: "onboard#setup"
  delete "/onboard/step/:step", to: "onboard#setup"
end
