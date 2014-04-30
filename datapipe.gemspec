Gem::Specification.new do |s|
  s.name        = 'datapipe'
  s.version     = '0.0.2'
  s.date        = '2014-05-01'
  s.summary     = "DataPipe"
  s.description = "Helping to move data around your system"
  s.authors     = ["Guy Irvine"]
  s.email       = 'guy@guyirvine.com'
  s.files       = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'http://rubygems.org/gems/datapipe'
  s.add_dependency( "json" )
  s.add_dependency( "fluiddb" )
  s.add_dependency( "parse-cron" )
  s.executables << 'datapipe'
end
