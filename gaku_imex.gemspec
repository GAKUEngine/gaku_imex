# encoding: UTF-8

Gem::Specification.new do |s|
  s.platform     = Gem::Platform::RUBY
  s.name         = 'gaku_imex'
  s.version      = '0.0.1'
  s.summary      = 'Importers and exporters for GAKU'
  s.description  = "Importers and exporters for GAKU"
  s.required_ruby_version = '~> 2.0.0'

  s.authors      = ['Rei Kagetsuki', 'Vassil Kalkov']
  s.email        = 'info@genshin.org'
  s.homepage     = 'http://github.com/Genshin/gaku_imex'

  s.files = `git ls-files`.split($RS)
  s.test_files = s.files.grep(/^spec\//)
  s.require_path = 'lib'

  s.requirements << 'postgres'
  s.requirements << 'redis'

  s.add_dependency 'gaku_core',    '~> 0.1.1'
  s.add_dependency 'gaku_testing', '~> 0.1.1'
  s.add_dependency 'gaku_admin',   '~> 0.1.1'

  s.add_dependency 'sidekiq'
  s.add_dependency 'sinatra'

  s.add_dependency 'smarter_csv'

end
