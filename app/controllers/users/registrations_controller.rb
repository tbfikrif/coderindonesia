module Users
  class RegistrationsController < Devise::RegistrationsController
    respond_to :json

    protected

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    private

    def respond_with(resource, _opts = {})
      resource.persisted? ? register_success : register_failed
    end

    def register_success
      render_jsonapi_response(resource)
    end

    def register_failed
      render json: {
        message: I18n.t('devise.registrations.signed_up_failure'),
        error: resource.errors.messages
      }, status: :bad_request
    end
  end
end
