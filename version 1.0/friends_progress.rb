class FriendsProgress < UrlInfo
  def initialize(url = "GET /api/users/{user_id}/get_friends_progress")
    super url
  end
end