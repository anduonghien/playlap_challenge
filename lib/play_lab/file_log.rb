module PlayLab
  class FileLog
    attr_reader :path

    def initialize path
      unless path.to_s == ""
        @path = path.to_s
      else
        raise ParamEmptyError
      end
    end

    def read
      begin
        File.read path.to_s
      rescue => e
        abort(e.to_s)
      end
    end
  end
end