#Gaku::Core::Engine.routes.prepend do
Gaku::Core::Engine.routes.draw  do

  namespace :admin do
    resources :students_importers, only: %i( index create show )
  end

end