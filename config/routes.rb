Rails.application.routes.draw do
  devise_for :patients, controllers: {
    registrations: 'patients/registrations'
  }

  resources :patients
  root 'home#index'
end
