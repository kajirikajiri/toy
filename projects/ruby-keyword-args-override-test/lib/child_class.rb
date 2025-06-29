require_relative 'base_class'

class ChildClass < BaseClass
  def process_data(name:, age: 25, city: "Osaka")
    result = super
    result[:overridden_by] = "ChildClass"
    result[:custom_message] = "Child class with different defaults"
    result
  end

  def calculate(x:, y: 5, operation: :multiply)
    result = super
    {
      result: result,
      overridden_by: "ChildClass",
      original_defaults: { y: 5, operation: :multiply }
    }
  end

  def flexible_method(**kwargs)
    result = super
    result[:processed_by] = "ChildClass"
    result[:additional_info] = "Child class processing"
    result
  end

  def child_specific_method(required_param:, optional_param: "default_child")
    {
      required_param: required_param,
      optional_param: optional_param,
      method_source: "ChildClass"
    }
  end
end