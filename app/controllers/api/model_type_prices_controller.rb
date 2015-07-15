class Api::ModelTypePricesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:show]

  def show
    group_org = get_group_org
    if group_org.present?

      render json: ['add service object here']
    else
      render json: {msg: 'Group organization not found.'}
    end
  end

  private

  def get_group_org
    GroupOrganization.where(id: params[:group_organization_id]).entries.first
  end
end
