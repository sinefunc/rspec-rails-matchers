module RSpecRailsMatchers
  module Associations
    module HaveOne
      def have_one(association)
        RSpec::Matchers::Matcher.new :have_one, association do |_association_|
          extend RSpecRailsMatchers::Associations::Helpers

          match do |model|
            associations(model, :has_one).any? { |a| a == _association_ }
          end

          failure_message_for_should do |model|
            RSpecRailsMatchers::Message.error(
              :expected => [ "%s to have one %s", model, _association_ ],
              :actual   => [ "%s has one %s", model, associations(model, :has_one) ]
            )
          end
        end
      end
    end
  end
end
