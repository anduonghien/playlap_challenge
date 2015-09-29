class Message < UrlInfo
  def initialize(url = "GET /api/users/{user_id}/get_messages")
    super url
  end
end