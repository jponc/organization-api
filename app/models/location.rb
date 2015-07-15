class Location
  include Mongoid::Document

  field :name, type: String
  field :address, type: String

  belongs_to :organization
end
