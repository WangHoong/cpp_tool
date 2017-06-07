class Api::V1::UsersController < Api::V1::BaseController
  #skip_load_and_authorize_resource

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @users = User.recent
    @users = @users.db_query(:name, params[:q]) if params[:q]
    @users = @users.where(status: params[:status]) if params[:status]
    @users = @users.page(page).per(size)
    render json: {users: @users.as_json(User.as_list_json_options), meta: page_info(@users)}
  end


  def show
    @user = User.find(params[:id])
    render json: {user: @user.as_json(User.as_list_json_options)}
  end

  def update
    @user = get_user
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  def destroy
    get_user.destroy
    head :ok
  end


  def current
    render json: {user: current_user.as_json(User.as_show_json_options)}
  end


  def update_pwd
      @user = current_user.authenticate(params[:user][:old_password])
      if @user
        current_user.update_attributes!(password: params[:user][:password])
        render json: current_user, serializer: UserDetailSerializer
      else
        render json: {status: 403, error: "Incorrect old password"}, status: :unauthorized
      end
  end


  private
  def get_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name,:email,:phone,:address,:avatar_url,:password,:role_ids=>[])
  end

end
