class Types::ActionEnumBrowserExtensionResult < Types::BaseEnum
  Action.browser_extension_results.keys.each do |result|
    value result
  end
end
