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

end
