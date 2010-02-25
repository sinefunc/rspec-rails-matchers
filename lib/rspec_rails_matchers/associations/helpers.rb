module RspecRailsMatchers
  module Associations
    module Helpers
      def associations( model, type )
        model.class.reflect_on_all_associations(type).map(&:name) 
      end
    end
  end
end
