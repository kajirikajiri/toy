require_relative 'base_class'

class ChildNoArgs < BaseClass
  def flexible_method
    result = super
    result[:processed_by] = "ChildNoArgs"
    result[:note] = "Child class with no arguments specified"
    result
  end

  def custom_flexible
    {
      message: "ChildNoArgs specific method",
      class_name: self.class.name
    }
  end
end