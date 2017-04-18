class ReportSerializer < ActiveModel::Serializer
  attributes :id,
    :dsp_id,
    :dsp_name,
    :start_time,
    :end_time,
    :income,
    :status,
    :created_at,
    :updated_at,
    :is_std,
    :is_split

  def dsp_name
    object.dsp && object.dsp.name
  end
end