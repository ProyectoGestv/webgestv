Webgestv::Application.routes.draw do

  resources :man_rscs

  root to: 'man_rscs#index', as: 'manres'

end
