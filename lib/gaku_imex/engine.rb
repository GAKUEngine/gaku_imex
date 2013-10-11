module GakuImex
  class Engine < Rails::Engine
    engine_name 'gaku_imex'

    config.autoload_paths += %W(#{config.root}/lib)
  end
end
