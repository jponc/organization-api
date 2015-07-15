class Organization
  include Mongoid::Document

  field :name, type: String
  field :public_name, type: String
  field :org_type, type: String
  field :pricing_policy, type: String

  embedded_in :group_organization
  embeds_many :locations

  ORG_TYPES = {
    SHOW_ROOM: 'show_room',
    SERVICE: 'service',
    DEALER: 'dealer'
  }

  PRICING_POLICIES = {
    FLEXIBLE: 'Flexible',
    FIXED: 'Fixed',
    PRESTIGE: 'Prestige'
  }

  ORG_TYPES.each do |k, v|
    define_method "#{v}?" do
      org_type == v
    end
  end
end
