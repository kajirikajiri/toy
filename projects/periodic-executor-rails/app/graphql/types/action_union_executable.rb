class Types::ActionUnionExecutable < Types::BaseUnion
  possible_types Types::VideoType, Types::WatchListType

  def self.resolve_type(object, context)
    case object
    when Video
      Types::VideoType
    when WatchList
      Types::WatchListType
    else
      raise("Unexpected object: #{object}")
    end
  end
end