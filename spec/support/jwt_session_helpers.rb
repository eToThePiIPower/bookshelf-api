module JWTSessionHelpers
  def login_as(user, request: nil, cookies: nil)
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
    token = session.login

    if request
      request.cookies[JWTSessions.access_cookie] = token[:access]
      request.headers[JWTSessions.csrf_header] = token[:csrf]
    elsif cookies
      cookies[JWTSessions.access_cookie] = token[:access]
    end
  end
end
