module RspecRailsMatchers
  module Validations
    include Rspec::Matchers

    def validate_presence_of(attribute)
      Matcher.new :validate_presence_of, attribute do |_attribute_|
        match do |model|
          model.send("#{_attribute_}=", nil)
          model.invalid? && model.errors[_attribute_].any?
        end

        failure_message_for_should do |model|
          RspecRailsMatchers::Message.error(
            :expected => 
              %(#{model.class.name} to validate presence of #{_attribute_})
          )
        end
      end
    end
   
    def validate_numericality_of( attribute, options = {} )
      Matcher.new :validate_numericality_of, attribute do |_attribute_|
        match do |model|
          invalid_on_non_numeric = lambda { 
            model.send("#{_attribute_}=", 'abcd')
            model.invalid? && 
              model.errors[_attribute_].include?(
                I18n::t('errors.messages.not_a_number')
              )
          }
          
          invalid_on_blank = lambda {
            model.send("#{_attribute_}=", nil)
            model.valid?

            !model.errors[_attribute_].include?(
              I18n::t('errors.messages.not_a_number')
            )
          }

          invalid_on_non_numeric.call && 
            (options[:allow_blank] == true ? invalid_on_blank.call : true)
        end

        failure_message_for_should do |model|
          RspecRailsMatchers::Message.error(
            :expected => 
              %(#{model.class.name} to validate numericality of #{_attribute_}, #{options.inspect})
          )
        end
      end
    end


    def validate_length_of(attribute, options)
      options.assert_valid_keys( :within, :minimum, :maximum )
      if options.has_key? :within
        min = options[:within].first
        max = options[:within].last
      elsif options.has_key? :minimum
        min = options[:minimum]
      elsif options.has_key? :maximum
        max = options[:maximum]
      end
      
      Matcher.new :validate_length_of, attribute do |_attribute_|
        match do |model|
          invalid = false

          if min && min >= 1
            model.send("#{attribute}=", 'a' * (min - 1))

            invalid = model.invalid? && 
              model.errors[_attribute_].include?(
                I18n::t('errors.messages.too_short', :count => min)
              )
          end

          if max
            model.send("#{attribute}=", 'a' * (max + 1))

            invalid ||= 
              model.invalid? && 
                model.errors[_attribute_].include?(
                  I18n::t('errors.messages.too_long', :count => max)
                )
          end
        end

        failure_message_for_should do |model|
          RspecRailsMatchers::Message.error(
            :expected =>
              %(#{model.class.name} to validate length of #{_attribute_}, #{options.inspect})
          )
        end
      end
    end

    def validate_uniqueness_of(attribute, options = {})
      Matcher.new :validate_uniqueness_of, attribute do |_attribute_|
        match do |model|
          m = model.class.new(_attribute_ => 'foobar')
          m.send("#{options[:scope]}=", 11) if options[:scope]
          m.save(:validate => false)
          
          model.send("#{_attribute_}=", "foobar")
          model.send("#{options[:scope]}=", 11) if options[:scope]

          model.invalid? && 
            model.errors[_attribute_].include?(
              I18n::t('activerecord.errors.messages.taken')
            )
        end

        failure_message_for_should do |model|
          RspecRailsMatchers::Message.error(
            :expected => 
              %(#{model.class.name} to validate uniqueness of #{_attribute_}, #{options.inspect})
          )
        end
      end
    end

    def validate_confirmation_of(attribute)
      Matcher.new :validate_confirmation_of, attribute do |_attribute_|
        match do |model|
          if model.respond_to?("#{attribute}_confirmation=")
            model.send("#{attribute}=", 'asdf')
            model.send("#{attribute}_confirmation=", 'asdfg')

            model.invalid? && 
              model.errors[_attribute_].include?(
                I18n::t('errors.messages.confirmation')
              )
          end
        end

        failure_message_for_should do |model|
          RspecRailsMatchers::Message.error(
            :expected => 
              %(#{model.class.name} to validate confirmation of #{_attribute_})
          )
        end
      end
    end
  end
end
