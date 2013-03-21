# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do

  match 'laynet_ele/testconn' => 'laynet_eles#testconn', :via => :get
  match 'net_ele/testconn' => 'net_eles#testconn', :via => :get
  match 'serv/testconn' => 'servs#testconn', :via => :get
  match "/update_linksb" => "links#update_linksb"

  resources :atrs
  resources :mcr_atrs
  resources :links
  resources :laynet_eles
  resources :net_eles
  resources :servs do
    get :delparams, on: :member
    get :upload_new, on: :member
    post :upload_create, on: :member
  end
  root :to => "static#index"
end
