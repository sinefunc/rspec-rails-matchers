require 'rspec'
require 'rspec/matchers'

$LOAD_PATH.unshift(File.expand_path('../../../', __FILE__))

module RspecRailsMatchers
  autoload :Message,      'rspec_rails_matchers/message'
  autoload :Validations,  'rspec_rails_matchers/validations'
  autoload :Associations, 'rspec_rails_matchers/associations'
end

Rspec.configure do |c|
  c.include RspecRailsMatchers::Validations
  c.include RspecRailsMatchers::Associations
end
