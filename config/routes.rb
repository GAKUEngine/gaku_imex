#Gaku::Core::Engine.routes.prepend do
Gaku::Core::Engine.routes.draw  do

  namespace :admin do
    resources :import_files do
      member do
        get :import
        get :check
      end
    end
  end

  resources :students do
    resources :reports, only: :index, controller: 'students/reports'
  end

  resources :exams do
    resources :reports, controller: 'exams/reports'
  end
  resources :courses, only: [] do
    resources :exams, only: [] do
      member do
        post :generate, to: 'courses/exams/reports#generate'
      end
    end
  end

end
