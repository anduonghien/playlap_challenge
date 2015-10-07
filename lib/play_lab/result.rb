module PlayLab
  class Result
    attr_reader :data
    attr_reader :text_plain

    # Public: initialize a new Result.
    # Init @text_plain with emplty
    # add resutl to text_plain
    # Raises Error::ParamTypeError if data not be String or String empty
    def initialize data
      if data.kind_of?(Hash)
        @data = data
        @text_plain = ""
      else
        raise Error::ParamTypeError
      end
    end

    # Public: add_result_to_text_palin 
    # Return text_plain include all resutl
    def add_result_to_text_palin
      @text_plain << "=====================PlayLab Chalenge=====================\n"
      @text_plain << "This is result after read file data/sample.log\n"
      @text_plain << "It result saved at result.txt\n\n"
      @data.each do |title, data|
        calculator(title, data)
      end
      @text_plain << "=====================AnDUONG====================="
    end

    # Public: write result to file result.txt and show it on terminal.
    def write_file_and_show_terminal
      add_result_to_text_palin
      write_to_file
      puts @text_plain
    end

    private
    # private print a Result.
    # Return nothing
    # Print result to terminal
    def add_one_result_to_text_plain(title, num_call = 0, time_average = 0, max_dyno = "Unknown")
      @text_plain << "=====================#{title}=====================\n"
      @text_plain << "The number of times the URL was called: #{num_call}\n"
      @text_plain << "The mean (average), median and mode of the response time (connect time + service time): #{time_average} ms\n"
      @text_plain << "The 'dyno' that responded the most: #{max_dyno}\n\n"
    end

    # Public: write result to result.txt 
    # Return file
    def write_to_file
      File.open("result.txt", 'w') {|f| f.write(@text_plain)}
    end

    # private calculator a array line logs.
    # Return nothing
    # Print result to terminal
    def calculator(title, data)
      if data.kind_of?(Array)
        num_call = data.count
        if num_call > 0
          time_arr = []
          dyno_hash = {}

          data.each do |line|
            connect = line.match(/connect=\d+/)[0].gsub(/connect=/,"").to_i
            service = line.match(/service=\d+/)[0].gsub(/service=/,"").to_i
            dyno = line.match(/dyno=web.\d+/)[0].gsub(/dyno=/,"")

            time_arr.push(connect + service)
            dyno_hash[dyno].nil? ? dyno_hash[dyno] = 1 : dyno_hash[dyno] += 1
          end

          add_one_result_to_text_plain(title, num_call, average_time(time_arr), max_dyno(dyno_hash))
        else
          add_one_result_to_text_plain(title)
        end
      else
        raise Error::ParamTypeError
      end
    end

    # private average_time a array line logs.
    # Return average from array time
    # Raises Error::ParamTypeError if param not be Array
    def average_time time_arr
      if time_arr.kind_of?(Array)
        time_arr.size == 0 ? "0.0" : (time_arr.inject{ |sum, el| sum + el }.to_f / time_arr.size).round(2).to_s
      else
        raise Error::ParamTypeError
      end
    end

    # private max_dyno a array line logs.
    # Return dyno max from hash with key:dyno_name, value: number
    # Raises Error::ParamTypeError if param not be Hash
    def max_dyno dyno_hash
      if dyno_hash.kind_of?(Hash)
        dyno_hash.key(dyno_hash.values.max).nil? ? "Unknown" : dyno_hash.key(dyno_hash.values.max).to_s
      else
        raise Error::ParamTypeError
      end
    end
  end
end