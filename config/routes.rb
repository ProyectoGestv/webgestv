# -*- encoding : utf-8 -*-
Webgestv::Application.routes.draw do

  #devise_for :users
  devise_for :users, :controllers => {:registrations => "users" }
  #match 'users' => 'users#index', :via => :get
  #match 'users/:id' => 'users#destroy', :via => :delete
  resources :users
  resources :atr_hsts
  match "/reports/index" => "reports#index"
  match '/reports/datostiemporeal' => 'reports#datostiemporeal'
  match '/actualizartabla' => 'reports#actualizartabla'
  match '/buscaratributo' => 'reports#buscaratributo'
  match '/buscarmacroatributo' => 'reports#buscarmacroatr'
  match '/rango' => 'reports#rango'
  resources :topologies
  resources :alrts
  
 

  resources :alr_mntr_frmls



  match 'laynet_ele/testconn' => 'laynet_eles#testconn', :via => :get
  match 'net_ele/testconn' => 'net_eles#testconn', :via => :get
  match 'serv/testconn' => 'servs#testconn', :via => :get
  match "/update_linksb" => "links#update_linksb"
  match "/update_alerts" => "alrts#update_alerts"

  match "/frmls/state" => "alr_mntr_frmls#state", :via => :get
  match "/alr_mntr_cntrs/state" => "alr_mntr_cntrs#state"
  match "/alr_mntr_rngs/state" => "alr_mntr_rngs#state"
  match "/man_rscs/mngable" => "man_rscs#mngable"
  match "/man_rscs/alrtable" => "man_rscs#alrtable"

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
