class ReadFile
  attr_accessor :path

  def initialize path
    @path = path
  end

  def read_file
    begin
      File.read path.to_s
    rescue => e
      abort(e.to_s)
    end
  end
end