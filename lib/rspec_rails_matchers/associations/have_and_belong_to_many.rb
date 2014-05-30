module RSpecRailsMatchers
  module Associations
    module HaveAndBelongToMany
      def have_and_belong_to_many(association)
        RSpec::Matchers::Matcher.new :have_and_belong_to_many, association do |_association_|
          extend RSpecRailsMatchers::Associations::Helpers

          match do |model|
            associations(model, :has_and_belongs_to_many).any? { |a| a == _association_ }
          end

          failure_message_for_should do |model|
            RSpecRailsMatchers::Message.error(
              :expected => [ "%s to have and belong to %s", model, _association_ ],
              :actual   => [ "%s has and belongs to %s", model, associations(model, :has_and_belongs_to_many) ]
            )
          end
        end
      end
    end
  end
end
