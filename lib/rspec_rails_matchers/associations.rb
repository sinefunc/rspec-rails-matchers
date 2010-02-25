module RspecRailsMatchers
  module Associations
    autoload :Helpers,             'rspec_rails_matchers/associations/helpers'
    autoload :HaveMany,            'rspec_rails_matchers/associations/have_many'
    autoload :BelongTo,            'rspec_rails_matchers/associations/belong_to'
    autoload :HaveOne,             'rspec_rails_matchers/associations/have_one'
    autoload :HaveAndBelongToMany, 'rspec_rails_matchers/associations/have_and_belong_to_many'

    include HaveMany
    include BelongTo
    include HaveOne
    include HaveAndBelongToMany
  end
end
