module RspecRailsMatchers
  module Behavior
    autoload :Lint, 'rspec_rails_matchers/behavior/lint'
    
    include Lint
  end
end
