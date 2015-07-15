class GroupOrganization
  include Mongoid::Document

  field :name, type: String
  field :org_code, type: String

  embeds_many :orgnizations


end
