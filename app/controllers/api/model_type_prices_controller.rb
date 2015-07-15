class Api::ModelTypePricesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:show]

  def show
    group_org = get_group_org

    resp =
      if group_org.present?
        Organization::ModelTypePriceComputation.new(
          group_org: group_org,
          model_type_name: params[:model_type_name],
          base_price: params[:base_price]
        ).compute
      else
        {msg: 'Group organization not found.'}
      end

    render json: resp
  end

  private

  def get_group_org
    GroupOrganization.where(id: params[:group_organization_id]).entries.first
  end
end
