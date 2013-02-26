Webgestv::Application.routes.draw do

  resources :net_eles

  resources :servs

  root to: 'servs#index', as: 'servs'

end
