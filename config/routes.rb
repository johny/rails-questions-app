Questions::Application.routes.draw do


  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users


  namespace :admin do
    resources :questions do
      resources :answers
    end
    get '/', to: 'admin#dashboard', as: 'dashboard'
  end

end