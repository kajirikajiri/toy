module Callbacks
  class ReverseStringCallback
    def initialize(attribute)
      @attribute = attribute
    end

    def before_save(record)
      record.send("#{@attribute}=", record.send(@attribute).reverse)
    end

    def after_save(record)
      record.send("#{@attribute}=", record.send(@attribute).reverse)
    end
  end
end
