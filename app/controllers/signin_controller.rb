class SigninController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_authorized

  def create
    user = User.find_by!(email: params[:email])
    if user.authenticate(params[:password])
      tokens = update_response!(response, user: user)
      render json: { csrf: tokens[:csrf] }
    else
      not_authorized
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def update_response!(response, user:)
    payload = { user_id: user.id }
    session = JWTSessions::Session.new(
      payload: payload,
      refresh_by_access_allowed: true
    )
    tokens = session.login

    response.set_cookie(
      JWTSessions.access_cookie,
      value: tokens[:access],
      httponly: true,
      secure: Rails.env.production?
    )

    tokens
  end
  # rubocop:enable Metrics/MethodLength

  # Redfine not_authorized for signin to ensure all authorization failures on
  # login show the same error to a potential attacker
  def not_authorized
    render json: {
      error: 'Email or password are invalid',
      status: :unauthorized
    }, status: :unauthorized
  end
end
