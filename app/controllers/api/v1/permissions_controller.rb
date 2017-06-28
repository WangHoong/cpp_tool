class Api::V1::PermissionsController < Api::V1::BaseController

  def index

    @role = Role.find(params[:role_id])
    @permission_ids = @role.permissions.map(&:id)
    @groups = PermissionGroup.recent.rootes
    groups = @groups.map{|g| Hash[{id: g.id,name: g.name,subclass: g.subclass.includes(:permissions).map{|m| Hash[{id: m.id,name: m.name,
        permissions: m.permissions.map{|n| Hash[{id: n.id,display_name: n.display_name,rule_type: n.rule_type,name: n.name,is_selectd: n.is_selectd(@permission_ids)}]}}]}}]}
    render json: {groups: groups}

  end



end
