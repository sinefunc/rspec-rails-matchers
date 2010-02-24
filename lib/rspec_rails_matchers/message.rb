module RspecRailsMatchers
  module Message
    def self.error( options = {} )
      msg =  %(expected #{options[:expected]})
      msg << %(\n     got #{options[:got]}) if options[:got]
      msg << %(\n  actual #{options[:actual]}) if options[:actual]
      msg << %(\n)
      msg
    end
  end
end
