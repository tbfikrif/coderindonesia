module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
      if current_user
        render_jsonapi_response(current_user)
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
