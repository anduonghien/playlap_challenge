module PlayLab
  class Result
    attr_reader :data

    def initialize data
      if data.kind_of?(Hash)
        @data = data
      else
        raise Error::ParamTypeError
      end
    end

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
    def print(title, num_call = 0, time_average = 0, max_dyno = "Unknown")
      puts "=====================#{title}====================="
      puts "The number of times the URL was called: #{num_call}"
      puts "The mean (average), median and mode of the response time (connect time + service time): #{time_average} ms"
      puts "The 'dyno' that responded the most: #{max_dyno}"
      puts "\n"
    end

    def calculator(title, data)
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
    end

    def average_time time_arr
      time_arr.size == 0 ? "0.0" : (time_arr.inject{ |sum, el| sum + el }.to_f / time_arr.size).round(2).to_s
    end

    def max_dyno dyno_hash
      dyno_hash.key(dyno_hash.values.max).nil? ? "Unknown" : dyno_hash.key(dyno_hash.values.max)
    end
  end
end