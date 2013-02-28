Webgestv::Application.routes.draw do
  resources :net_eles
  resources :servs
  root :to => "static#index"
end
