class FriendsScore < UrlInfo
  def initialize(url = "GET /api/users/{user_id}/get_friends_score")
    super url
  end
end