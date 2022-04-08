module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    private

    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed
    end

    def register_success
      render json: {
        message: I18n.t('devise.registrations.signed_up'),
        id: current_user.id,
        email: current_user.email,
        first_name: current_user.first_name,
        user_type: current_user.user_type.text,
        'token-type': 'Bearer',
        'access-token': current_user.token
      }, status: :ok
    end

    def register_failed
      render json: {
        message: I18n.t('devise.registrations.signed_up_failure'),
        error: resource.errors.messages
      }, status: :bad_request
    end
  end
end
