#Gaku::Core::Engine.routes.prepend do
Gaku::Core::Engine.routes.draw  do

  namespace :admin do
    resources :students_importers, only: %i( index create ) do
      collection do
        get :get_roster
        get :get_registration_roster
      end
    end

    resources :syllabuses_importers, only: :index
  end

end