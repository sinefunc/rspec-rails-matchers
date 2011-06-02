module RSpecRailsMatchers
  module Behavior
    autoload :Lint, 'rspec_rails_matchers/behavior/lint'
    
    include Lint
  end
end
