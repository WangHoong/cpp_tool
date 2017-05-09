class Api::V1::RolesController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @roles = Role.order(id: :desc)
    @roles = @roles.where(name: params[:q]) if params[:q]
    @roles = @roles.page(page).per(size)
    render json: {roles: @roles.as_json(only: [:id, :name,:status]), meta: page_info(@roles)}
  end


  def show
    @role = Role.find(params[:id])
    render json: {role: @role.as_json(Role.as_json_options)}
  end

  def update
    @role = get_role
    if @role.update(role_params)
      render json: @role
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  def create
    @role = Role.new(role_params)
    if @role.save
      render json: @role
    else
      render json: @role.errors, status: :unprocessable_entity
    end
  end

  def destroy
    get_role.destroy
    head :ok
  end

  def permissions
    @groups = PermissionGroup.recent.roots
    groups = []
    @groups.each do |group|
        groups << {id: group.id,name: group.name,subclass: group.descendants.includes(:permissions).as_json(PermissionGroup.as_list_json_options)}
    end
    render json: {groups: groups}
  end

  private
  def get_role
    Role.find(params[:id])
  end

  def role_params
    params.require(:role).permit(:name,:status,:permission_ids => [])
  end
end
