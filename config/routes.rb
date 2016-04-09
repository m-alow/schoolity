Rails.application.routes.draw do
  resources :schools do
    resources :school_classes do
      resources :classrooms
    end
  end
end
