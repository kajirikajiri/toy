class Types::ActionEnumPattern < Types::BaseEnum
  Action.patterns.keys.each do |pattern|
    value pattern
  end
end