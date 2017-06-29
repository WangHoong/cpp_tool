class Api::V1::Videos::QuerySerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :video_resources,
             :cover_resources
  def video_resources
    @video_resources = object.video_resources
    @video_resources.map { |v| {
      name: v.resource.native_name,
      url: v.resource.url
    }}
  end
  def cover_resources
    @cover_resources = object.cover_resources
    @cover_resources.map { |v| {
      name: v.resource.native_name,
      url: v.resource.url
    }}
  end
  # has_many :primary_artists, serializer: Api::V1::Albums::ArtistSerializer
  # has_many :featuring_artists, serializer: Api::V1::Albums::ArtistSerializer
end
