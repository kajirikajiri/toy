class Types::ActionEnumStatus < Types::BaseEnum
  Action.statuses.keys.each do |status|
    value status
  end
end