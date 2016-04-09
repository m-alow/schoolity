Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :schools do
    resources :school_classes do
      resources :classrooms
    end
  end
end
