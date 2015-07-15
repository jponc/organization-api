class Location
  include Mongoid::Document

  field :name, type: String
  field :address, type: String

  embedded_in :organization
end
