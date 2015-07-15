class GroupOrganization
  include Mongoid::Document

  field :name, type: String
  field :org_code, type: String

  embeds_many :organizations

  def locations
    organizations.map(&:locations).flatten
  end

  def location_names
    locations.map(&:name)
  end
end
