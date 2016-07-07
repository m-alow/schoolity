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
    end
    resources :school_administrations, except: [:edit, :update]
    resources :announcements, module: :schools, only: [:index, :new, :create]
  end

  resources :followings, except: [:edit, :update]
  resources :lessons, only: [:update, :show] do
    put '/students/:student_id/activity' => 'activities#update', as: :student_activity
    resources :activities, only: [:index, :show], shallow: true do
      get :edit, on: :collection
      resources :comments, only: [:create], module: :activities
    end
    resources :comments, only: [:create], module: :lessons
  end

  resources :announcements, only: [:show, :edit, :update, :destroy] do
    resources :comments, only: [:create], module: :announcements
  end

  resources :grades, only: [:show] do
    resources :comments, only: [:create], module: :grades
  end

  namespace :teacher do
    get '/' => 'panel#index'
    get '/exams' => 'panel#exams'
    get '/announcements' => 'panel#announcements'
    resources :agendas, param: :date, only: [:index, :show, :edit]
  end

  namespace :parent do
    get '/' => 'panel#index', as: :panel
    get '/feed' => 'feed#index'
    resources :followings, only: :show do
      resources :agendas, only: [:index, :show], param: :date
      resources :grades, only: [:index]
    end
  end

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        post '/sign_up' => 'registrations#create'
        post '/sign_in' => 'sessions#create'

        namespace :parent do
          resources :followings, only: [:index, :create, :destroy], shallow: true do
            get 'timetable' => 'timetables#current'
            get 'agendas/:year-:month-:day' => 'agendas#show_by_date'
          end
        end
      end
    end
  end
end
