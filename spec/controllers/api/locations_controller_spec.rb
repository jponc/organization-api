require 'rails_helper'

describe Api::LocationsController do
  describe 'GET show' do
    let(:group_org_id) { '111' }
    before do
      controller.stubs(:get_group_org).returns(group_org)
    end
    context 'group organization is present' do
      let(:group_org) { stub('GroupOrganization') }
      let(:location_names) { ['location1', 'location2'] }
      it 'calls the location_names' do
        group_org.expects(:location_names)
        get :show, group_organization_id: group_org_id
      end

      it 'returns the location names' do
        group_org.stubs(:location_names).returns(location_names)
        get :show, group_organization_id: group_org_id
        json = JSON(response.body)
        expect(json).to eq location_names
      end
    end

    context 'group organization is not present' do
      let(:group_org) { nil }

      it "does not call the location_names" do
        GroupOrganization.any_instance.expects(:location_names).never
        get :show, group_organization_id: group_org_id
      end

      it 'returns an error message' do
        get :show, group_organization_id: group_org_id
        json = JSON(response.body)
        expect(json['msg']).to eq 'Group organization not found.'
      end
    end
  end
end
