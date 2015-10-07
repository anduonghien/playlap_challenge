module PlayLab
  class Result
    attr_reader :data

    # Public: initialize a new Result.
    # Raises Error::ParamTypeError if data not be String or String empty
    def initialize data
      if data.kind_of?(Hash)
        @data = data
      else
        raise Error::ParamTypeError
      end
    end

    # Public: show a Result.
    # Return nothing
    # Print result to terminal
    def show
      puts "=====================PlayLab Chalenge====================="
      puts "This is result after read file data/sample.log"
      puts "\n"
      @data.each do |title, data|
        calculator(title, data)
      end
      puts "=====================AnDUONG====================="
    end

    private
    # private print a Result.
    # Return nothing
    # Print result to terminal
    def print(title, num_call = 0, time_average = 0, max_dyno = "Unknown")
      puts "=====================#{title}====================="
      puts "The number of times the URL was called: #{num_call}"
      puts "The mean (average), median and mode of the response time (connect time + service time): #{time_average} ms"
      puts "The 'dyno' that responded the most: #{max_dyno}"
      puts "\n"
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

          print(title, num_call, average_time(time_arr), max_dyno(dyno_hash))
        else
          print(title)
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