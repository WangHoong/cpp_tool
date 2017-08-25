require 'rest-client'


class UploadUtil
  URL = "http://upload.topdmc.com.cn"

  class << self
    def upload(dir, file)

      if file.is_a? File
        path = file.path
      end

      if file.is_a? StringIO
        temp = Tempfile.new(['temp', '.xlsx'])
        temp.write file.read
        temp.close
        path = temp.path
      end
      filename = "#{Time.now.to_i}-#{SecureRandom.hex(8)}.xlsx"
      @bucket = BosClient::Bucket.new(name: Rails.application.secrets.dmc_ro)
      ret = BosClient::Object.upload(path: dir,
                                file: path,
                                filename: filename,
                                bucket: @bucket)

      if ret
        err = nil
        url = "#{@bucket.bucket_host}/#{dir}/#{filename}"
        temp.unlink if temp.present?
        return url, err
      end
      #res = JSON.parse(RestClient.post("#{URL}?category=#{category}", :file => File.open(path)).body)
      #
      # if res.is_a? Array
      #   url = res[0]['url']
      # elsif res.is_a?(Hash)
      #   err = res['message']
      # end
      #
      # temp.unlink if temp.present?
      #
      # return url, err
    end
  end
end
