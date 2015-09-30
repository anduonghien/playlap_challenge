require_relative 'read_file'
require_relative 'convert_content'
require_relative 'calculator'

class PlayLabChallenge
  def self.run
    file = ReadFile.new "data/sample.log"
    file_content = file.read_file
    # Get data has been type
    convert = ConvertContent.new file_content
    hash_data = convert.convert_to_hash
    # Get result
    calcu = Calculator.new hash_data
    calcu.result
  end
end

PlayLabChallenge.run