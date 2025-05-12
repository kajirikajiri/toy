# frozen_string_literal: true

require_relative './lib/outer_module'
require_relative './lib/outer_module/inner_module'
require_relative './lib/parent_class'
require_relative './lib/parent_class/child_class'

# puts OuterModule::InnerModule.hello

# # ネストしたクラスの例
# puts ParentClass::ChildClass.new.hello