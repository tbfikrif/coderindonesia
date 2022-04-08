module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
      if current_user
        render json: {
          message: I18n.t('devise.sessions.signed_in'),
          id: current_user.id,
          email: current_user.email,
          first_name: current_user.first_name,
          user_type: current_user.user_type.text,
          'token-type': 'Bearer',
          'access-token': current_user.token
        }, status: :ok
      else
        render json: {
          message: I18n.t('devise.failure.invalid', authentication_keys: 'username/email')
        }, status: :unauthorized
      end
    end

    def respond_to_on_destroy
      current_user ? log_out_success : log_out_failure
    end

    def log_out_success
      render json: { message: I18n.t('devise.sessions.signed_out') }, status: :ok
    end

    def log_out_failure
      render json: { message: I18n.t('devise.sessions.signed_out_failure') }, status: :unauthorized
    end
  end
end
