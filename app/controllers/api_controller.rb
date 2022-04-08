class ApiController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    render json: { errors: exception.message }, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {
      errors: I18n.t('activerecord.errors.messages.not_found', model: exception.model.constantize.model_name.human)
    }, status: :not_found
  end
end
