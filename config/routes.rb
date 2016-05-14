Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index', as: 'dashboard'
  get 'dashboard' => 'dashboard#index', as: 'user_root'

  root to: 'static_pages#home'
  get 'about' => 'static_pages#about'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :schools, shallow: true do
    put 'activation', action: :activate, on: :member
    resources :school_classes do
      resources :classrooms do
        resources :students, only: [:index, :new, :create], controller: 'classrooms/students'
      end
      resources :subjects
    end
    resources :students do
      resources :studyings
    end
    resources :school_administrations, except: [:edit, :update]
  end
end
