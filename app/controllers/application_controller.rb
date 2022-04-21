class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def render_jsonapi_response(resource)
    if resource.errors.empty?
      render jsonapi: resource
    else
      render jsonapi_errors: resource.errors, status: 400
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = %i[username email password password_confirmation remember_me
                     avatar first_name last_name phone_number programming_skill
                     date_of_birth profession user_type]
    update_attrs = %i[avatar first_name last_name phone_number programming_skill
                      date_of_birth profession user_type]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: %i[login password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def jsonapi_meta(resources)
    if resources.token.present?
      {
        'token-type': 'Bearer',
        'access-token': resources.token
      }
    end
  end
end
