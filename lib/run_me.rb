require_relative 'play_lab/helper'

class RunMe
  def self.run
    file = PlayLab::FileLog.new "data/sample.log"
    file_content = file.read
    # Get data has been type
    content_log = PlayLab::ContentLog.new file_content
    hash_content_data = content_log.convert_to_hash
    # Get result
    result = PlayLab::Result.new hash_content_data
    result.write_file_and_show_terminal
  end
end

RunMe.run