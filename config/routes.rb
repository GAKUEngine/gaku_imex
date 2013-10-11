Gaku::Core::Engine.routes.prepend do
  resources :students do
    collection do

      resources :importer, controller: 'students/importer', only: %i( index create ), as: 'student_importer' do
        collection do
          get :get_roster
          get :get_registration_roster
        end
      end

    end
  end


  resources :syllabuses do
    collection do
      resources :importer, controller: 'syllabuses/importer', only: %i( index ), as: 'syllabus_importer'
    end
  end

end