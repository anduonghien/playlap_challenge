module PlayLab
  class FileLog
    attr_reader :path

    # Public: initialize a new FileLog.
    # Raises Error::ParamEmptyError if path not be String or String empty
    def initialize path
      unless path.to_s == ""
        @path = path.to_s
      else
        raise Error::ParamEmptyError
      end
    end

    # Public: read file
    # Return String content file
    # exit system when can't read file
    def read
      begin
        File.read path.to_s
      rescue => e
        abort(e.to_s)
      end
    end
  end
end