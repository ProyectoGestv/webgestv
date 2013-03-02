# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do
  match 'net_ele/testconn' => 'net_eles#testconn', :via => :get
  match 'serv/testconn' => 'servs#testconn', :via => :get
  resources :net_eles
  resources :servs
  root :to => "static#index"
end
