BitcoinApp::Application.routes.draw do
  get "home/rates", to: "home#rates"
  root :to => 'home#index'
  resources :home

end
