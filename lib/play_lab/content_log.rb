module PlayLab
  require_relative 'variable_template'

  class ContentLog < VariableTemplate
    attr_reader :content

    def initialize content
      unless content.to_s == ""
        @content = content.to_s
      else
        raise Error::ParamEmptyError
      end
    end

    def convert_to_hash
      count_pending_lines = []
      message_lines = []
      friends_progress_lines = []
      friends_score_lines = []
      get_user_lines = []
      post_user_lines = []

      lines = split_via_new_line
      lines.each do |line|
        case line
        when COUNT_PENDING[:regular]
          count_pending_lines.push(line)
        when MESSAGE[:regular]
          message_lines.push(line)
        when FRIENDS_PROGRESS[:regular]
          friends_progress_lines.push(line)
        when FRIENDS_SCORE[:regular]
          friends_score_lines.push(line)
        when GET_USER[:regular]
          get_user_lines.push(line)
        when POST_USER[:regular]
          post_user_lines.push(line)
        end
      end

      {
        COUNT_PENDING[:title]    => count_pending_lines,
        MESSAGE[:title]          => message_lines,
        FRIENDS_PROGRESS[:title] => friends_progress_lines,
        FRIENDS_SCORE[:title]    => friends_score_lines,
        GET_USER[:title]         => get_user_lines,
        POST_USER[:title]        => post_user_lines
      }
    end

    private
    def split_via_new_line
      @content.split("\n")
    end
  end
end