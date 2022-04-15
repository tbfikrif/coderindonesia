class ApiController < ActionController::Base
  include JSONAPI::Fetching
  include JSONAPI::Filtering
  include JSONAPI::Pagination

  rescue_from CanCan::AccessDenied do |_exception|
    render json: {
      errors: [
        status: 403,
        source: {
          pointer: params[:controller]
        },
        title: 'Forbidden',
        detail: I18n.t('unauthorized.invalid_access'),
        code: 'forbidden'
      ]
    }, status: :forbidden
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: {
      errors: [
        status: 404,
        source: {
          pointer: "#{exception.model.constantize.model_name.singular}/data"
        },
        title: 'Not Found',
        detail: I18n.t('activerecord.errors.messages.not_found', model: exception.model.constantize.model_name.human),
        code: 'not_found'
      ]
    }, status: :not_found
  end

  rescue_from ActionController::ParameterMissing do |exception|
    render json: {
      errors: [
        status: 400,
        source: {
          pointer: "param :#{exception.to_s.split(': ').last}"
        },
        title: 'Bad Request',
        detail: I18n.t(
          'activerecord.errors.messages.params_is_missing',
          model: exception.to_s.split(': ').last.camelize.constantize.model_name.human
        ),
        code: 'bad_request'
      ]
    }, status: :bad_request
  end

  private

  def jsonapi_page_size(pagination_params)
    per_page = pagination_params[:size].to_f.to_i
    per_page = 10 if per_page > 10 || per_page < 1
    per_page
  end

  def jsonapi_meta(resources)
    pagination = jsonapi_pagination_meta(resources)

    { pagination: } if pagination.present?
  end
end
