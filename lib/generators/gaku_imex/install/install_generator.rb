require 'rails/generators'
require 'highline/import'
require 'bundler'
require 'bundler/cli'

module GakuImex
  class InstallGenerator < Rails::Generators::Base

    class_option :auto_accept, type: :boolean
    class_option :lib_name, type: :string, default: 'gaku_imex'
    class_option :env, type: :string, default: 'development'

    def self.source_paths
      paths = superclass.source_paths
      paths << File.expand_path('../templates', "../../#{__FILE__}")
      paths << File.expand_path('../templates', "../#{__FILE__}")
      paths << File.expand_path('../templates', __FILE__)
      paths.flatten
    end

    def prepare_options
      @env = options[:env]
    end

    def clear_logs
      remove_file 'log/sidekiq.log'
      add_file 'log/sidekiq.log'
    end

    def add_files
      template 'config/sidekiq.yml', 'config/sidekiq.yml'
      template 'Procfile', 'Procfile'
    end

    def add_migrations
      run 'rake railties:install:migrations FROM=gaku_imex'
    end

    def run_migrations
      run_migrations = options[:auto_run_migrations] || ['', 'y', 'Y'].include?(ask 'Would you like to run the migrations now? [Y/n]')
      if run_migrations
        run 'rake db:migrate'
      else
        puts "Skiping rake db:migrate, don't forget to run it!"
      end
    end

    def notify_about_routes
      insert_into_file File.join('config', 'routes.rb'), after: "Application.routes.draw do\n" do
        %Q{
  # This line mounts GakuImex routes

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

        }
      end

      unless options[:quiet]
        puts '*' * 50
        puts "We added the following line to your application's config/routes.rb file:"
        puts ' '
        puts "    mount Sidekiq::Web => '/sidekiq'"
      end
    end

    def complete
      unless options[:quiet]
        puts '*' * 50
        puts "GakuImex has been installed successfully. You're all ready to go!"
        puts ' '
        puts 'Enjoy!'
      end
    end

  end
end
