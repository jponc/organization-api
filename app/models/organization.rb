class Organization
  include Mongoid::Document

  field :name, type: String
  field :public_name, type: String
  field :org_type, type: String


  belongs_to :group_organization
  embeds_many :locations
end
