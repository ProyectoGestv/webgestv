# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do
  resources :atrs


  resources :mcr_atrs


  resources :links


  match 'laynet_ele/testconn' => 'laynet_eles#testconn', :via => :get
  match 'net_ele/testconn' => 'net_eles#testconn', :via => :get
  match 'serv/testconn' => 'servs#testconn', :via => :get
  match "/update_linksb" => "links#update_linksb"
  resources :laynet_eles
  resources :net_eles
  resources :servs
  root :to => "static#index"
end
