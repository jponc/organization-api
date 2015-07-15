class Organization::PriceMarginComputation

  def initialize(organization)
    @organization = organization
  end

  def compute
    policies = Organization::PRICING_POLICIES

    case @organization.pricing_policy
    when policies[:FLEXIBLE]
      compute_flexible
    when policies[:FIXED]
      compute_fixed
    when policies[:PRESTIGE]
      compute_prestige
    end
  end

  def compute_flexible
    body = Net::HTTP.get('www.reuters.com', '/')
    get_substr_length(body, 'a') / 100.0
  end

  def compute_fixed
    body = Net::HTTP.get('https://developer.github.com', '/v3/#http-redirects')
    get_substr_length(body, 'status')
  end

  def compute_prestige
    body = Net::HTTP.get('www.yourlocalguardian.co.uk', '/sport/rugby/rss/')
    get_substr_length(body, 'pubDate')
  end

  def get_substr_length (body, substring)
    body.scan(substring).length
  end
end
