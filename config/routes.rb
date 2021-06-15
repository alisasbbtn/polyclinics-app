Rails.application.routes.draw do
  root 'home#index'

  devise_for :doctors, controllers: {
    sessions: 'doctors/sessions'
  }

  devise_for :patients, controllers: {
    registrations: 'patients/registrations',
    sessions: 'patients/sessions'
  }

  resources :patients, only: %i[show edit update]
  resources :doctors, only: %i[show index]

  get '/doctors_by_category', to: 'doctors#doctors_by_category'

end
