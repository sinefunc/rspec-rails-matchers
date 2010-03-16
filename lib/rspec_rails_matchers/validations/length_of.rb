module RspecRailsMatchers
  module Validations
    module LengthOf
      def validate_length_of(attribute, options)
        options.assert_valid_keys( :within, :minimum, :maximum )
          
        min, max = min_max_for(options)
        
        Rspec::Matchers::Matcher.new :validate_length_of, attribute do |_attribute_|
          match do |model|
            validates_minimum?(model, min, _attribute_) && 
              validates_maximum?(model, max, _attribute_)
          end

          failure_message_for_should do |model|
            RspecRailsMatchers::Message.error(
              :expected => 
                [ "%s to validate length of %s, %s", model, _attribute_, options ]
            )
          end

         
          def validates_minimum?( model, min, attr )
            return true if not min

            if min && min >= 1
              model.send("#{attr}=", 'a' * (min - 1))

              model.invalid? && model.errors[attr].any?
            end
          end

          def validates_maximum?( model, max, attr )
            return true if not max

            if max
              model.send("#{attr}=", 'a' * (max + 1))

              model.invalid? && model.errors[attr].any?
            end
          end
        end
      end

      private
        def min_max_for( options )
          if options.has_key? :within
            min = options[:within].first
            max = options[:within].last
          elsif options.has_key? :minimum
            min = options[:minimum]
          elsif options.has_key? :maximum
            max = options[:maximum]
          end

          return min, max
        end
    end
  end
end
