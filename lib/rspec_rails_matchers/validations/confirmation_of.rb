module RspecRailsMatchers
  module Validations
    module ConfirmationOf
      def validate_confirmation_of(attribute)
        Rspec::Matchers::Matcher.new :validate_confirmation_of, attribute do |_attr_|
          match do |model|
            if model.respond_to?("#{_attr_}_confirmation=")
              model.send("#{_attr_}=", 'asdf')
              model.send("#{_attr_}_confirmation=", 'asdfg')

              model.invalid? && 
                model.errors[_attr_].include?(
                  I18n::t('errors.messages.confirmation')
                )
            end
          end

          failure_message_for_should do |model|
            RspecRailsMatchers::Message.error(
              :expected => [ "%s to validate confirmation of %s", model, _attr_ ]
            )
          end
        end
      end
    end
  end
end
