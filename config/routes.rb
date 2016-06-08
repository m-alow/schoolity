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
        resources :teachings
        resources :following_codes, only: [:index, :create], controller: 'classrooms/following_codes'
        resources :timetables do
          get 'initialize' => 'timetables#init', on: :new
        end
      end
      resources :subjects
    end
    resources :students do
      resources :studyings
      resources :following_codes, only: [:index, :show, :create, :destroy], controller: 'students/following_codes'
    end
    resources :school_administrations, except: [:edit, :update]
  end

  resources :followings, except: [:edit, :update]
end
