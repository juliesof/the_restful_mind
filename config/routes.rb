Rails.application.routes.draw do

  root 'home#index'

  resources :earned_badges

  devise_for :users, :controllers => { :registrations => 'registrations' }

  resources :users

  resources :sittings


end
