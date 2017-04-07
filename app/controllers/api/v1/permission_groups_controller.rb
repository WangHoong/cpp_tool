class Api::V1::PermissionGroupsController < Api::V1::BaseController

  def index
    @groups = PermissionGroup.includes(:subclass,:permissions).recent.where(parent_id: 0)
    render json: {groups: @groups.as_json(PermissionGroup.as_list_json_options)}
  end


end
