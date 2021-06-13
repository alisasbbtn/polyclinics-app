Rails.application.routes.draw do
  devise_for :patients, controllers: {
    registrations: 'patients/registrations'
  }

  root 'home#index'
end
