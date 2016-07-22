Rails.application.routes.draw do
  get 'dashboard' => 'dashboard#index', as: 'dashboard'
  get 'dashboard' => 'dashboard#index', as: 'user_root'

  root to: 'static_pages#home'
  get 'about' => 'static_pages#about'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :schools, shallow: true do
    put 'activation', action: :activate, on: :member
    resources :school_classes do
      resources :classrooms, shallow: true do
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

        resources :announcements, module: :classrooms, only: [:index, :new, :create]

        put '/lessons/:date/:order' => 'lessons#update_qualified', as: :update_lesson
      end
      resources :subjects, shallow: true
      resources :announcements, module: :school_classes, only: [:index, :new, :create]
    end
    resources :students do
      resources :studyings
      resources :following_codes, only: [:index, :show, :create, :destroy], controller: 'students/following_codes'
      resources :announcements, module: :students, only: [:index, :new, :create]
    end
    resources :school_administrations, except: [:edit, :update]
    resources :announcements, module: :schools, only: [:index, :new, :create]
  end

  resources :followings, except: [:edit, :update]
  resources :lessons, only: [:update, :show], shallow: true do
    put '/students/:student_id/activity' => 'activities#update', as: :student_activity
    resources :activities, only: [:index, :show], shallow: true do
      get :edit, on: :collection
      resources :comments, only: [:create], module: :activities
    end
    resources :comments, only: [:create], module: :lessons
    put '/students/:student_id/behavior' => 'lessons/behaviors#update', as: :student_behavior
    resources :behaviors, only: [:index], module: :lessons, shallow: true do
      get :edit, on: :collection
      resources :comments, only: [:create], controller: '/behaviors/comments'
    end
  end

  resources :announcements, only: [:show, :edit, :update, :destroy] do
    resources :comments, only: [:create], module: :announcements
  end

  resources :grades, only: [:show] do
    resources :comments, only: [:create], module: :grades
  end

  resources :comments, only: [:update, :destroy]
  resources :behaviors, only: [:show]

  resources :days do
    put '/students/:student_id/behavior' => 'days/behaviors#update', as: :student_behavior
    resources :behaviors, only: [:index], module: :days, shallow: true do
      get :edit, on: :collection
    end

    put '/students/:student_id/absence' => 'absences#update', as: :student_absence
    resources :absences, only: [:index, :destroy, :show], shallow: true do
      resources :comments, only: :create, module: :absences
    end
  end

  resources :messages, only: [:show] do
    resources :comments, only: :create, module: :messages
    end

  resources :notifications, only: [:show, :update]

  namespace :admin do
    resources :feed, only: [:index]
    resources :notifications, only: [:index] do
      get 'all' => 'notifications#all', on: :collection
    end
  end

  namespace :teacher do
    get '/' => 'panel#index'
    resources :feed, only: [:index]
    get '/exams' => 'panel#exams'
    get '/announcements' => 'panel#announcements'
    resources :agendas, param: :date, only: [:index, :show, :edit]
    resources :notifications, only: [:index] do
      get 'all' => 'notifications#all', on: :collection
    end
  end

  namespace :parent do
    get '/' => 'panel#index', as: :panel
    get '/feed' => 'feed#index'
    resources :followings, only: :show do
      resources :agendas, only: [:index, :show], param: :date
      resources :grades, only: [:index]
      resources :subjects, only: [:index]
      resources :behaviors, only: [:index]
      resources :activities, only: [:index]
      resources :absences, only: [:index]
      resources :messages, only: [:new, :create]
    end
    resources :notifications, only: [:index] do
      get 'all' => 'notifications#all', on: :collection
    end
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post '/sign_up' => 'registrations#create'
        post '/sign_in' => 'sessions#create'
        delete '/sign_out' => 'sessions#destroy'

        namespace :parent do
          resources :followings, only: [:index, :create, :destroy], shallow: true do
            get 'timetable' => 'timetables#current'
            get 'agendas/:year-:month-:day' => 'agendas#show_by_date'
            resources :grades, only: [:index], shallow: true do
              resources :comments, only: [:index, :create], module: :grades
            end
            resources :messages, only: [:index, :create, :show] do
              resources :comments, only: [:index, :create], module: :messages
            end
            resources :activities, only: [:index, :show] do
              resources :comments, only: [:index, :create], module: :activities
            end
            resources :behaviors, only: [:index, :show] do
              resources :comments, only: [:index, :create], module: :behaviors
            end
            resources :absences, only: [:index, :show] do
              resources :comments, only: [:index, :create], module: :absences
            end
          end
          resources :announcements, only: [:index, :show] do
            resources :comments, only: [:index, :create], module: :announcements
          end
          resources :lessons, only: [:show] do
            resources :comments, only: [:index, :create], module: :lessons
          end
          resources :feed, only: [:index]
          resources :notifications, only: [:index] do
            get 'all' => 'notifications#all', on: :collection
          end
          resources :tokens, only: [:create]
        end

        resources :comments, only: [:update, :destroy]
      end
    end
  end
end
