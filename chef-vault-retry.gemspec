$:.push File.expand_path('../lib', __FILE__)
require 'chef-vault-retry/version'

Gem::Specification.new do |s|
  s.name             = 'chef-vault-retry'
  s.version          = ChefVaultRetry::VERSION
  s.authors          = ['Biola University']
  s.email            = ['sysadmins@biola.edu']
  s.summary          = 'Retry support for chef-vault'
  s.description      = s.summary
  s.homepage         = 'https://github.com/biola/chef-vault-retry'

  s.license          = 'Apache License, v2.0'

  s.files            = `git ls-files`.split("\n")
  s.require_paths    = ['lib']

  s.add_runtime_dependency 'chef-vault', '~> 2.6'
end
