module RSpecRailsMatchers
  module Associations
    module HaveMany
      def have_many(association)
        RSpec::Matchers::Matcher.new :have_many, association do |_association_|
          extend RSpecRailsMatchers::Associations::Helpers

          match do |model|
            associations(model, :has_many).any? { |a| a == _association_ }
          end

          failure_message_for_should do |model|
            RSpecRailsMatchers::Message.error(
              :expected => [ "%s to have have many %s", model, _association_ ],
              :actual   => [ "%s has many %s", model, associations(model, :has_many) ]
            )
          end
        end
      end
    end
  end
end
