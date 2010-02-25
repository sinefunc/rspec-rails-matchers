module RspecRailsMatchers
  module Validations
    module UniquenessOf
      def validate_uniqueness_of(attribute, options = {})
        Rspec::Matchers::Matcher.new :validate_uniqueness_of, attribute do |_attr_|
          match do |model|
            duplicate = create_duplicate_record(model, _attr_, options[:scope])

            if options[:scope]
              model.send("#{options[:scope]}=", duplicate.send(options[:scope]))
            end
            
            model.send("#{_attr_}=", "foobar")

            model.invalid? && 
              model.errors[_attr_].include?(
                I18n::t('activerecord.errors.messages.taken')
              )
          end

          failure_message_for_should do |model|
            RspecRailsMatchers::Message.error(
              :expected => 
                [ "%s to validate uniqueness of %s, %s", model, _attr_, options ]
            )
          end
          
          def create_duplicate_record( model, attr, scope )
            m = model.class.new(attr => 'foobar')
            m.send("#{scope}=", 11) if scope
            m.save(:validate => false)
            m
          end
        end
      end
    end
  end
end
