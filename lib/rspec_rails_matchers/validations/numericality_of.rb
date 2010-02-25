module RspecRailsMatchers
  module Validations
    module NumericalityOf
      def validate_numericality_of( attribute, options = {} )
        Rspec::Matchers::Matcher.new :validate_numericality_of, attribute do |_attr_|
          match do |model|
            invalid_on_non_numeric?(model, _attr_) && 
              (options[:allow_blank] == true ? 
                 invalid_on_blank?(model, _attr_) : true
              )
          end

          failure_message_for_should do |model|
            RspecRailsMatchers::Message.error(
              :expected => 
                [ "%s to validate numericality of %s, %s", model, _attr_, options ]
            )
          end

          def invalid_on_non_numeric?( model, attr )
            model.send("#{attr}=", 'abcd')
            model.invalid? && 
              model.errors[attr].include?(
                I18n::t('errors.messages.not_a_number')
              )
          end
  
          def invalid_on_blank?( model, attr )
            model.send("#{attr}=", nil)
            model.valid?

            !model.errors[attr].include?(
              I18n::t('errors.messages.not_a_number')
            )
          end
        end
      end
    end
  end
end

