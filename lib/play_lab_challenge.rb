require_relative 'play_lab/helper'

class PlayLabChallenge
  def self.run
    file = PlayLab::FileLog.new "data/sample.log"
    file_content = file.read
    # Get data has been type
    content_log = PlayLab::ContentLog.new file_content
    hash_data = content_log.convert_to_hash
    # Get result
    result = PlayLab::Result.new hash_data
    result.show
  end
end

PlayLabChallenge.run