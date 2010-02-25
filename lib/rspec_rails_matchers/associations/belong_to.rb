module RspecRailsMatchers
  module Associations
    module BelongTo
      def belong_to(association)
        Rspec::Matchers::Matcher.new :belong_to, association do |_association_|
          extend RspecRailsMatchers::Associations::Helpers

          match do |model|
            associations(model, :belongs_to).any? { |a| a == _association_ }
          end

          failure_message_for_should do |model|
            RspecRailsMatchers::Message.error(
              :expected  => [ "%s to belong to %s", model, _association_ ],
              :actual    => [ "%s belongs to %s", model, associations(model, :belongs_to) ]
            )
          end
        end
      end
    end
  end
end
