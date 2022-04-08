module Users
  class SessionsController < Devise::SessionsController
    respond_to :json

    private

    def respond_with(_resource, _opts = {})
      if current_user
        render json: {
          success: true,
          message: 'Login success.',
          id: current_user.id,
          email: current_user.email,
          first_name: current_user.first_name,
          'token-type': 'Bearer',
          'access-token': current_user.token
        }, status: :ok
      else
        render json: { success: false, message: 'Invalid login credentials' }, status: :unauthorized
      end
    end

    def respond_to_on_destroy
      current_user ? log_out_success : log_out_failure
    end

    def log_out_success
      render json: { message: 'Logged out.' }, status: :ok
    end

    def log_out_failure
      render json: { message: 'Logged out failure.' }, status: :unauthorized
    end
  end
end
