# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do

  resources :alr_mntrs


  match 'laynet_ele/testconn' => 'laynet_eles#testconn', :via => :get
  match 'net_ele/testconn' => 'net_eles#testconn', :via => :get
  match 'serv/testconn' => 'servs#testconn', :via => :get
  match "/update_linksb" => "links#update_linksb"

  resources :uploads do
    post :new, on: :member
    post :load, on: :member
  end

  resources :links

  resources :laynet_eles do
    get :delparams, on: :member
    resources :mcr_atrs do
      resources :atrs
      match "/atrs_sim" => "atrs#index_sim"
      match "/atrs_con" => "atrs#index_con"
      match "/atrs_com" => "atrs#index_com"
    end
  end
  resources :net_eles do
    get :delparams, on: :member
    resources :mcr_atrs do
      resources :atrs
      match "/atrs_sim" => "atrs#index_sim"
      match "/atrs_con" => "atrs#index_con"
      match "/atrs_com" => "atrs#index_com"
    end
  end
  resources :servs do
    get :delparams, on: :member
    resources :mcr_atrs do
      resources :atrs
      match "/atrs_sim" => "atrs#index_sim"
      match "/atrs_con" => "atrs#index_con"
      match "/atrs_com" => "atrs#index_com"
    end
  end
  root :to => "static#index"
end
