require 'rspec'
require 'rspec/matchers'

$LOAD_PATH.unshift(File.expand_path('../', __FILE__))

module RSpecRailsMatchers
  autoload :Message,      'rspec_rails_matchers/message'
  autoload :Validations,  'rspec_rails_matchers/validations'
  autoload :Associations, 'rspec_rails_matchers/associations'
  autoload :Behavior,     'rspec_rails_matchers/behavior'
  autoload :Sugar,        'rspec_rails_matchers/sugar'
end

RSpec.configure do |c|
  c.include RSpecRailsMatchers::Validations
  c.include RSpecRailsMatchers::Associations
  c.include RSpecRailsMatchers::Behavior
  c.include RSpecRailsMatchers::Sugar
end
