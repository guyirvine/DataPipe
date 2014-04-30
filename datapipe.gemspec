Gem::Specification.new do |s|
  s.name        = 'datapipe'
  s.version     = '0.0.1'
  s.date        = '2014-04-30'
  s.summary     = "RServiceBus"
  s.description = "Helping to move data around your system"
  s.authors     = ["Guy Irvine"]
  s.email       = 'guy@guyirvine.com'
  s.files       = Dir["{lib}/**/*.rb", "bin/*", "LICENSE", "*.md"]
  s.homepage    = 'http://rubygems.org/gems/rservicebus'
  s.add_dependency( "json" )
  s.add_dependency( "beanstalk-client" )
  s.add_dependency( "fluiddb" )
  s.add_dependency( "parse-cron" )
  s.executables << 'datapipe'
end
