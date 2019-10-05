class SignupController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save
      tokens = update_response!(response, user: user)
      render json: { csrf: tokens[:csrf] }
    else
      render json: {
        error: user.errors.full_messages.join(' '),
        status: :unprocessable_entity
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

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
end
