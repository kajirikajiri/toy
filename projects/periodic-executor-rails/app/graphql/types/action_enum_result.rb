class Types::ActionEnumResult < Types::BaseEnum
  Action.results.keys.each do |result|
    value result
  end
end