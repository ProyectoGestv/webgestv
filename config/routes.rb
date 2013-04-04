# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do
  #resources :alr_mntr_rngs
  #resources :alr_mntr_cntrs

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
      resources :atrs do
        resources :alr_mntr_cntrs
      end
      match "/atrs_sim" => "atrs#index_sim"
      match "/atrs_con" => "atrs#index_con"
      match "/atrs_com" => "atrs#index_com"
    end
  end

  #resources :alr_mntr_cntrs
  match 'alr_mntrs/new(/:mcr_atr_id)' => 'alr_mntrs#new', :as => :new_alr_mntr
  match 'alr_mntrs/new(/:mcr_atr_id(/:atr_id))' => 'alr_mntrs#new', :as => :new_alr_mntr
  #match 'alr_mntr_cntr/new(/:atr_id)' => 'alr_mntr_cntrs#new', :as => :new_alr_mntr_cntr
  root :to => "static#index"
end
