require_relative '../lib/base_class'
require_relative '../lib/child_class'
require_relative '../lib/child_with_extras'
require_relative '../lib/child_no_args'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end