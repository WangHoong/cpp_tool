class Api::V1::PermissionsController < Api::V1::BaseController

  def index
    @role = Role.find(params[:role_id])
    @permission_ids = @role.permissions.map(&:id)
    @groups = PermissionGroup.includes(:subclass,:permissions).recent.where(parent_id: 0)

    @groups.each do |group|
        groups << {id: group.id,name: group.name,subclass: group.descendants.includes(:permissions).as_json(PermissionGroup.as_list_json_options)}
    end
    render json: {groups: groups}

  end



end
