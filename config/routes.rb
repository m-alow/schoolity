Rails.application.routes.draw do
  root to: 'static_pages#home'
  get 'about' => 'static_pages#about'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :schools do
    resources :school_classes do
      resources :classrooms
    end
  end
end
