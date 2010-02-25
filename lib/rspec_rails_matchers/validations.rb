module RspecRailsMatchers
  module Validations
    autoload :PresenceOf,     'rspec_rails_matchers/validations/presence_of'
    autoload :NumericalityOf, 'rspec_rails_matchers/validations/numericality_of'
    autoload :LengthOf,       'rspec_rails_matchers/validations/length_of'
    autoload :UniquenessOf,   'rspec_rails_matchers/validations/uniqueness_of'
    autoload :ConfirmationOf, 'rspec_rails_matchers/validations/confirmation_of'

    include PresenceOf
    include NumericalityOf
    include LengthOf
    include UniquenessOf
    include ConfirmationOf
  end
end
