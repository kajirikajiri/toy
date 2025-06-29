require_relative 'base_class'

class ChildWithExtras < BaseClass
  def process_data(name:, age: 30, city: "Kyoto", country: "Japan", **extra_params)
    result = super(name: name, age: age, city: city)
    result[:country] = country
    result[:extra_params] = extra_params
    result[:overridden_by] = "ChildWithExtras"
    result
  end

  def calculate(x:, y: 1, operation: :add, precision: 2, **options)
    base_result = super(x: x, y: y, operation: operation)
    {
      result: base_result.round(precision),
      precision: precision,
      options: options,
      overridden_by: "ChildWithExtras"
    }
  end

  def flexible_method(required_key:, **kwargs)
    result = super(**kwargs)
    result[:required_key] = required_key
    result[:processed_by] = "ChildWithExtras"
    result[:has_required_param] = true
    result
  end

  def extended_method(base_param:, extra_param: "extra_default", **remaining)
    {
      base_param: base_param,
      extra_param: extra_param,
      remaining_params: remaining,
      method_source: "ChildWithExtras"
    }
  end
end