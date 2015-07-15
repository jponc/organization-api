class Api::LocationsController < ApplicationController
  def show
    group_org = get_group_org
    if group_org.present?
      render json: group_org.location_names
    else
      render json: {msg: 'Group organization not found.'}
    end
  end

  private

  def get_group_org
    GroupOrganization.where(id: params[:group_organization_id]).entries.first
  end
end
