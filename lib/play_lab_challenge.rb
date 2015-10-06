require_relative 'play_lab/helper'

class PlayLabChallenge
  def self.run
    file = PlayLab::FileLog.new "data/sample.log"
    file_content = file.read
    # Get data has been type
    convert = ConvertContent.new file_content
    hash_data = convert.convert_to_hash
    # Get result
    calcu = Calculator.new hash_data
    calcu.result
  end
end

# PlayLabChallenge.run
PlayLab::FileLog.new ""