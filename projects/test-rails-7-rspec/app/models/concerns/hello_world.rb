module HelloWorld
  extend ActiveSupport::Concern

  included do
    def example_method
      'Hello, World!'
    end
  end
end
