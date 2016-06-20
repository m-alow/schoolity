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
          get 'current', on: :collection
        end
        resources :agendas, except: [:new, :create, :show, :edit] do
          get 'today', on: :collection
          get '/:date' => 'agendas#show_by_date', on: :collection, as: :date
          get '/:date/edit' => 'agendas#edit', on: :collection, as: :edit
        end

        resources :exams, shallow: false
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
  resources :lessons, only: [:update] do
    put '/students/:student_id/activity' => 'activities#update', as: :student_activity
    resources :activities, only: [:index] do
      get :edit, on: :collection
    end
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post '/sign_up' => 'registrations#create'
        post '/sign_in' => 'sessions#create'

        namespace :parent do
          resources :followings, only: [:index, :create, :destroy]
        end
      end
    end
  end
end
