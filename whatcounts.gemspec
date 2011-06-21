require 'rake'
Gem::Specification.new do |s|
  s.name = "whatcounts"
  s.version = "0.0.0"
  s.date = "2011-06-17"
  s.authors = ["Lucia Huntting", "HomePipe Networks"]
  s.email = "luciamkh@gmail.com"
  s.summary = "Ruby gem for interacting with the WhatCounts HTTP API"
  s.files = FileList['lib/**/*.rb', 'bin/*', '[A-Z]*', 'test/**/*'].to_a
  s.has_rdoc = false
  s.add_dependency('curb', '>= 0.7.15')
end