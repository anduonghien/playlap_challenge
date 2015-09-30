class VariableTemplate
  COUNT_PENDING =     {
                      title: "GET /api/users/{user_id}/count_pending_messages",
                      regular: /method=GET path=\/api\/users\/\p{Digit}+\/count_pending_messages/
                      }

  MESSAGE =           {
                      title: "GET /api/users/{user_id}/get_messages",
                      regular: /method=GET path=\/api\/users\/\p{Digit}+\/get_messages/
                      }

  FRIENDS_PROGRESS =  {
                      title: "GET /api/users/{user_id}/get_friends_progress",
                      regular: /method=GET path=\/api\/users\/\p{Digit}+\/get_friends_progress/
                      }

  FRIENDS_SCORE =     {
                      title: "GET /api/users/{user_id}/get_friends_score",
                      regular: /method=GET path=\/api\/users\/\p{Digit}+\/get_friends_score/
                      }

  GET_USER =          {
                      title: "GET /api/users/{user_id}",
                      regular: /method=GET path=\/api\/users\/\p{Digit}+ /
                      }

  POST_USER =         {
                      title: "POST /api/users/{user_id}",
                      regular: /method=POST path=\/api\/users\/\p{Digit}+ /
                      }
end