spec = Gem::Specification.new do |s|
  s.name = "renoter"
  s.version = '0.0.2'
  s.summary = "Renoter API ruby wrapper."
  s.description = %{Some simple methods in Renoter class to interact with http://renoter.com}
  s.files = ['README', 'lib/renoter.rb']
  s.require_path = 'lib'
  s.autorequire = 'renoter'
  s.has_rdoc = true
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.author = "cheetah"
  s.email = "thcheetah@gmail.com"
  s.homepage = "http://github.com/cheetah/renoter"
  
  s.add_dependency('json', '>= 1.1.4')
end