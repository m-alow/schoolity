Rails.application.routes.draw do
  # resources :school_classes
  resources :schools do
    resources :school_classes
  end
end
