Gem::Specification.new do |s|
  s.name        = 'collectd-resque'
  s.version     = '0.0.2'
  s.date        = '2016-03-14'
  s.summary     = 'collectd wrapper for Resque'
  s.description = 'Provides collectd with access to Resque stats for Queue Length and WIP'
  s.authors     = ['Chris Young']
  s.email       = 'chris@worldofchris.com'
  s.files       = ['lib/resque_status.rb']
  s.executables << 'collectd_resque.rb'
  s.license     = 'MIT'
  s.homepage    = 'https://github.com/worldofchris/collectd-resque'
end
