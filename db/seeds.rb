# GENERATE GROUP ORGANIZATION
group_organization = GroupOrganization.create(name: 'Aureso', org_code: 'AUR')

# GENERATE ORGANIZATIONS
show_room = group_organization.organizations.create(
  name: 'Aureso Show Room', public_name: 'Aureso Show Room',
  org_type: Organization::ORG_TYPES[:SHOW_ROOM],
  pricing_policy: Organization::PRICING_POLICIES[:FLEXIBLE]
)

service = group_organization.organizations.create(
  name: 'Aureso Service', public_name: 'Aureso Service',
  org_type: Organization::ORG_TYPES[:SERVICE],
  pricing_policy: Organization::PRICING_POLICIES[:FIXED]
)

dealer = group_organization.organizations.create(
  name: 'Aureso Dealer', public_name: 'Aureso Dealer',
  org_type: Organization::ORG_TYPES[:DEALER],
  pricing_policy: Organization::PRICING_POLICIES[:PRESTIGE]
)

# GENERATE LOCATIONS
show_room.locations.create([
  {name: 'Aureso SF', address: 'San Francisco, California'},
  {name: 'Aureso NY', address: 'New York, New York'},
  {name: 'Aureso TX', address: 'San Austin, Texas'},
])

service.locations.create(name: 'Aureso SG', address: 'Singapore, Singapore')
dealer.locations.create(name: 'Aureso PH', address: 'Manila, Philippines')
