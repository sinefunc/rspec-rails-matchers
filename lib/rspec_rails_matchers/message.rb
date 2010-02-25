module RspecRailsMatchers
  module Message
    def self.error( options = {} )
      msg =    %(expected #{transform(options[:expected])})
      msg << %(\n     got #{transform(options[:got])}) if options[:got]
      msg << %(\n  actual #{transform(options[:actual])}) if options[:actual]
      msg << %(\n)
      msg
    end

    private
      def self.transform( str_or_array )
        case str_or_array
        when String
          str_or_array
        when Array
          puts str_or_array[1..-1].inspect
          sprintf str_or_array[0], *prettify(str_or_array[1..-1])
        else
          raise ArgumentError, "Message#error expects a String or Array"
        end  
      end

      def self.prettify( array )
        array.map do |a|
          case a
          when Hash               then a.inspect
          when ActiveRecord::Base then a.class.name
          else
            a.inspect
          end
        end
      end
  end
end
