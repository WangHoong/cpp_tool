class Api::V1::DepartmentsController < Api::V1::BaseController

  def index
    @departments = Department.order(id: :desc)
    render json: {departments: @departments}
  end



end
