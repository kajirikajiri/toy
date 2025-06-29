class BaseClass
  def process_data(name:, age: 20, city: "Tokyo")
    {
      name: name,
      age: age,
      city: city,
      class_name: self.class.name
    }
  end

  def calculate(x:, y: 10, operation: :add)
    case operation
    when :add
      x + y
    when :multiply
      x * y
    when :subtract
      x - y
    else
      raise ArgumentError, "Unknown operation: #{operation}"
    end
  end

  def flexible_method(**kwargs)
    {
      received_keys: kwargs.keys,
      received_values: kwargs.values,
      class_name: self.class.name
    }
  end
end