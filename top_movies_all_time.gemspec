# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'top_movies_all_time/version'

Gem::Specification.new do |spec|
  spec.name          = "top_movies_all_time"
  spec.version       = TopMoviesAllTime::VERSION
  spec.authors       = ["Kevin Adkins"]
  spec.email         = ["kevinladkins@gmail.com"]

  spec.summary       = %q{top-grossing movies of all time}
  spec.description   = %q{top-grossing movies of all time (domestic, worldwide, and inflation-adjusted)}
  spec.homepage      = "https://github.com/kevinladkins/top-movies-all-time-cli-app"
  spec.license       = "MIT"
  spec.executables << 'top-movies-all-time'



  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "colorize", ">=0"
end
