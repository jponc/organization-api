require 'rails_helper'

describe Api::ModelTypePricesController do
  describe 'POST show' do
    let(:group_org_id) { '111' }
    before do
      controller.stubs(:get_group_org).returns(group_org)
    end
    context 'group organization is present' do
      let(:group_org) { stub('GroupOrganization') }
      let(:model_type_name) { 'porsche_911' }
      let(:base_price) { '111' }
      let(:params) do
        {group_organization_id: group_org_id, model_type_name: model_type_name, base_price: base_price}
      end

      let(:service) { stub('Organization::ModelTypePriceComputation') }

      it 'instantiate org service to compute model type price' do
        service_params = { group_org: group_org, model_type_name: model_type_name, base_price: base_price }
        Organization::ModelTypePriceComputation.expects(:new).with(service_params).returns(service)
        service.expects(:compute)
        post :show, params
      end
    end

    context 'group organization is not present' do
      let(:group_org) { nil }

      it "does not instantiate price computation service" do
        Organization::ModelTypePriceComputation.expects(:new).never
        post :show, group_organization_id: group_org_id
      end

      it 'returns an error message' do
        post :show, group_organization_id: group_org_id
        json = JSON(response.body)
        expect(json['msg']).to eq 'Group organization not found.'
      end
    end
  end
end
