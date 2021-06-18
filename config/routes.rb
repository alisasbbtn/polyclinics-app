Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'

  devise_for :doctors, controllers: {
    sessions: 'doctors/sessions'
  }

  devise_for :patients, controllers: {
    registrations: 'patients/registrations',
    sessions: 'patients/sessions'
  }

  resources :patients, only: %i[show edit update] do
    resources :appointments, only: :index
  end

  resources :doctors, only: %i[show index] do
    resources :appointments do
      collection do
        get 'available_hours', to: 'appointments#available_hours'
      end
    end
    resources :patients, only: :index
  end
end
