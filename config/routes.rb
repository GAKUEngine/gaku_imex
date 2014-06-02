#Gaku::Core::Engine.routes.prepend do
Gaku::Core::Engine.routes.draw  do

  namespace :admin do
    resources :import_files do
      get :import, on: :member
    end
  end

end
