# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do

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
    end
  end
  resources :net_eles do
    get :delparams, on: :member
    resources :mcr_atrs do
      resources :atrs
    end
  end
  resources :servs do
    get :delparams, on: :member
    resources :mcr_atrs do
      resources :atrs
    end
  end

  resources :man_rscs do
    resources :mcr_atrs do
      resources :atrs do
        resources :alr_mntr_cntrs
        resources :alr_mntr_rngs
      end
    end
  end

  root :to => "static#index"
end
