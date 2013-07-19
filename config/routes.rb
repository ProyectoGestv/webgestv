# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do

 match "/reports/index" => "reports#index"
 match '/reports/getdatos' => 'reports#getdatos'
 match '/actualizar' => 'reports#actualizar'
 match '/buscaratr' => 'reports#buscaratr'
 match '/rango' => 'reports#rango'


 resources :alrts
  
 

  resources :alr_mntr_frmls



  match 'laynet_ele/testconn' => 'laynet_eles#testconn', :via => :get
  match 'net_ele/testconn' => 'net_eles#testconn', :via => :get
  match 'serv/testconn' => 'servs#testconn', :via => :get
  match "/update_linksb" => "links#update_linksb"

  match "/frmls/state" => "alr_mntr_frmls#state", :via => :get
  match "/alr_mntr_cntrs/state" => "alr_mntr_cntrs#state"
  match "/alr_mntr_rngs/state" => "alr_mntr_rngs#state"

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
      resources :alr_mntr_frmls
      resources :atrs do
        resources :alr_mntr_cntrs
        resources :alr_mntr_rngs
      end
    end
  end

  root :to => "static#index"
end
