# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do
  resources :net_eles
  match 'sauce' => 'net_eles#sauce', :via => :get
  resources :servs
  root :to => "static#index"
end
