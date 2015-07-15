require 'rails_helper'
describe Organization::ModelTypePriceComputation do
  let(:org) { stub('Organization') }
  let(:group_org) { stub('GroupOrganization', organizations: [org]) }
  let(:model_type_name) { 'porsche_911' }
  let(:base_price) { '111' }
  let(:margin_price) { 555 }
  let(:service_params) do
   { group_org: group_org, model_type_name: model_type_name, base_price: base_price }
  end
  let(:service) { Organization::ModelTypePriceComputation.new(service_params) }

  describe '#compute' do
    it 'calls get_org_base_price for each organization' do
      service.expects(:get_org_base_price).with(org)
      service.compute
    end

    it 'returns a hash with model type name and corresponding base_price' do
      service.stubs(:get_org_base_price).returns(margin_price)
      expect(service.compute).to include({model_type_name: model_type_name, base_price: margin_price})
    end
  end

  describe '#get_org_base_price' do
    let(:price_margin_service) { stub('Organization::PriceMarginComputation') }
    it 'calls the price margin computation' do
      Organization::PriceMarginComputation.expects(:new).with(org).returns(price_margin_service)
      price_margin_service.expects(:compute).returns(margin_price)
      service.get_org_base_price org
    end

    it 'returns the sum of base price and margin price' do
      Organization::PriceMarginComputation.any_instance.stubs(:compute).returns(margin_price)
      expect(service.get_org_base_price(org)).to eq(BigDecimal(base_price) + margin_price)
    end
  end
end
