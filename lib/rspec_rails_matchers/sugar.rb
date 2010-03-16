module RspecRailsMatchers
  module Sugar
    def its(attribute, &block)
      describe("its #{attribute}") do
        define_method(:subject) { super().send(attribute) }
        it(&block)
      end
    end
  end
end

