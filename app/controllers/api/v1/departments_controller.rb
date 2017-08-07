class Api::V1::DepartmentsController < Api::V1::BaseController

  def index
    #revenue = Revenue.find(25)
    #response = revenue.analyses_data(:mismatched)

    @departments = Department.order(id: :desc)
    render json: {departments: @departments}
  end



end
