# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do
  resources :net_eles
  resources :servs
  match 'neteles/testconn' => 'net_eles#testconn', :via => :get
  match 'servs/testconn' => 'servs#testconn', :via => :get
  root :to => "static#index"
end
