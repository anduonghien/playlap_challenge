class UrlInfo
  attr_accessor :url, :num_call, :time_arr, :dyno_hash
  
  def initialize url
    self.url = url
    self.num_call = 0
    self.time_arr = []
    self.dyno_hash = {}
  end

  def time_average
    time_arr.size == 0 ? "0.0" : (time_arr.inject{ |sum, el| sum + el }.to_f / time_arr.size).to_s
  end

  def max_dyno
    dyno_hash.key(dyno_hash.values.max).nil? ? "Unknow" : dyno_hash.key(dyno_hash.values.max)
  end

  def result
    p "=====================#{url}====================="
    p "The number of times the URL was called: #{num_call}"
    p "The mean (average), median and mode of the response time (connect time + service time): #{time_average} ms"
    p "The 'dyno' that responded the most: #{max_dyno}"
  end
end