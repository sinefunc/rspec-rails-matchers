module RspecRailsMatchers
  module Associations
    include Rspec::Matchers

    def belong_to(association)
      Matcher.new :belong_to, association do |_association_|
        match do |model|
          klass = model.class if model.is_a?(ActiveRecord::Base)
          klass.reflect_on_all_associations(:belongs_to).detect { |a|
            a.name == _association_
          }
        end

        failure_message_for_should do |model|
          klass = model.class if model.is_a?(ActiveRecord::Base)
          
          associations = klass.reflect_on_all_associations(:belongs_to).map(&:name)
          RspecRailsMatchers::Message.error(
            :expected  => "#{klass.name} to belong to #{_association_}",
            :actual    => "#{klass.name} belongs to #{associations.any? ? associations.join(', ') : 'none'}"
          )
        end

      end
    end


    def have_many(association)
      Matcher.new :have_many, association do |_association_|
        match do |model|
          klass = model.class if model.is_a?(ActiveRecord::Base)
          klass.reflect_on_all_associations(:has_many).detect { |a|
            a.name == _association_
          }
        end

        failure_message_for_should do |model|
          klass = model.class if model.is_a?(ActiveRecord::Base)
          
          RspecRailsMatchers::Message.error(
            :expected => "#{klass.name} to have have many #{_association_}",
            :got      => "#{klass.reflect_on_all_associations(:has_many).map(&:name).inspect}"
          )
        end
      end
    end
  end
end
