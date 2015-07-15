class Organization::ModelTypePriceComputation

  def initialize(options)
    @options = options
  end

  def compute
    group_org.organizations.map do |org|
      {model_type_name: model_type_name, base_price: get_org_base_price(org)}
    end
  end

  def get_org_base_price org
    base_price + Organization::PriceMarginComputation.new(org).compute
  end

  # Memoized values

  def group_org
    @group_org ||= @options[:group_org]
  end

  def model_type_name
    @model_type_name ||= @options[:model_type_name]
  end

  def base_price
    @base_price ||= BigDecimal(@options[:base_price])
  end
end
