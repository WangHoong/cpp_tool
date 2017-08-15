class Api::V1::TasksController < Api::V1::BaseController
  # Post /tasks
  def create
    result = []
    params.require(:album_ids).each do |id|
      if Task.find_by(:album_id => id, :status => 0)
        result << {
          id: id,
          success: false,
          message: "此任务正在等待处理中,请不要重复提交。"
        }
        next
      end

      @album = Album.find_by(:id => id)
      if (!@album)
        result << {
          id: id,
          success: false,
          message: "没有此 album"
        }
        next
      end

      if @album.status == "rejected"
        result << {
          id: id,
          success: false,
          message: "此album审核未通过"
        }
        next
      end

      @task = Task.new(:album_id => id)
      @album.sync_status = 1

      if @task.save
        if @album.save
          result << {
            id: id,
            success: true
          }
          next
        else
          @task.destroy
        end
      end

      result << {
        id: id,
        success: false,
        message: "创建失败请重试，或联系管理员。"
      }
    end

    render json: result
  end
end
