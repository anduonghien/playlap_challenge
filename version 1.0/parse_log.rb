require 'pry'
require_relative 'url_info'
require_relative 'pending_message'
require_relative 'message'
require_relative 'friends_progress'
require_relative 'friends_score'
require_relative 'user'

class ParseLog
  # GET /api/users/{user_id}/count_pending_messages
  COUNT_PENDING_REGULAR = /method=GET path=\/api\/users\/\p{Digit}+\/count_pending_messages/
  # GET /api/users/{user_id}/get_messages
  MESSAGE_REGULAR = /method=GET path=\/api\/users\/\p{Digit}+\/get_messages/
  # GET /api/users/{user_id}/get_friends_progress
  PROGRESS_REGULAR = /method=GET path=\/api\/users\/\p{Digit}+\/get_friends_progress/
  # GET /api/users/{user_id}/get_friends_score
  SCORE_REGULAR = /method=GET path=\/api\/users\/\p{Digit}+\/get_friends_score/
  # GET /api/users/{user_id}
  GET_USER_REGULAR = /method=GET path=\/api\/users\/\p{Digit}+ /
  # POST /api/users/{user_id}
  POST_USER_REGULAR = /method=POST path=\/api\/users\/\p{Digit}+ /

  def initialize
    @pending_messages = PendingMessage.new
    @message = Message.new
    @friends_progress = FriendsProgress.new
    @friends_score = FriendsScore.new
    @get_user = User.new("GET /api/users/{user_id}")
    @post_user = User.new("POST /api/users/{user_id}")
  end

  def read_file file_path
    begin
      string_data = File.read file_path
      lines = string_data.split("\n")
    rescue => e
      p e
    end
  end

  def calculation data
    data.each do |line|
      connect = line.match(/connect=\d+/)[0].gsub(/connect=/,"").to_i
      service = line.match(/service=\d+/)[0].gsub(/service=/,"").to_i
      dyno = line.match(/dyno=web.\d+/)[0].gsub(/dyno=/,"")
      case line
      when COUNT_PENDING_REGULAR
        @pending_messages.num_call += 1
        @pending_messages.time_arr.push(connect + service)
        @pending_messages.dyno_hash[dyno].nil? ? @pending_messages.dyno_hash[dyno] = 1 : @pending_messages.dyno_hash[dyno] += 1
      when MESSAGE_REGULAR
        @message.num_call += 1
        @message.time_arr.push(connect + service)
        @message.dyno_hash[dyno].nil? ? @message.dyno_hash[dyno] = 1 : @message.dyno_hash[dyno] += 1
      when PROGRESS_REGULAR
        @friends_progress.num_call += 1
        @friends_progress.time_arr.push(connect + service)
        @friends_progress.dyno_hash[dyno].nil? ? @friends_progress.dyno_hash[dyno] = 1 : @friends_progress.dyno_hash[dyno] += 1
      when SCORE_REGULAR
        @friends_score.num_call += 1
        @friends_score.time_arr.push(connect + service)
        @friends_score.dyno_hash[dyno].nil? ? @friends_score.dyno_hash[dyno] = 1 : @friends_score.dyno_hash[dyno] += 1
      when GET_USER_REGULAR
        @get_user.num_call += 1
        @get_user.time_arr.push(connect + service)
        @get_user.dyno_hash[dyno].nil? ? @get_user.dyno_hash[dyno] = 1 : @get_user.dyno_hash[dyno] += 1
      when POST_USER_REGULAR
        @post_user.num_call += 1
        @post_user.time_arr.push(connect + service)
        @post_user.dyno_hash[dyno].nil? ? @post_user.dyno_hash[dyno] = 1 : @post_user.dyno_hash[dyno] += 1
      end
    end
  end

  def result
    @pending_messages.result
    @message.result
    @friends_progress.result
    @friends_score.result
    @get_user.result
    @post_user.result
  end
end
# Call
parse_log = ParseLog.new
data = parse_log.read_file "../data/sample.log"
parse_log.calculation data
parse_log.result
