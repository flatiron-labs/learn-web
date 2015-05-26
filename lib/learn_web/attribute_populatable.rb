module LearnWeb
  module AttributePopulatable
    def populate_attributes!
      data.each do |attribute, value|
        if !self.respond_to?(attribute)
          class << self
            attr_accessor attribute
          end
        end

        self.send("#{attribute}=", value)
      end
    end
  end
end
