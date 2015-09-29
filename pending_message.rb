class PendingMessage < UrlInfo
  def initialize(url = "GET /api/users/{user_id}/count_pending_messages")
    super url
  end
end