spec = Gem::Specification.new do |s|
  s.name = "renoter"
  s.version = '0.0.2' # Версия гема, при изменении этого параметра github заного пересобирает ваш гем
  s.summary = "Renoter API ruby wrapper."
  s.description = %{Some simple methods in Renoter class to interact with http://renoter.com}
  s.files = ['README', 'lib/renoter.rb'] # Файлы, входящие в гем
  s.require_path = 'lib'
  s.autorequire = 'renoter' # Файл, подключаемый по умолчанию, вы пишете require 'renoter', а подключается lib/renoter.rb
  s.has_rdoc = true # Включаем генерацию документации
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"] # Настройки rdoc
  s.author = "cheetah"
  s.email = "thcheetah@gmail.com"
  s.homepage = "http://github.com/cheetah/renoter"
  
  s.add_dependency('json', '>= 1.1.4') # Добавляем в зависимости гем json, не ниже версии 1.1.4, если его не будет, то он установится вместе с нашим автоматически
end