class HomeController < ApplicationController
  def index
    render_jsonapi_response(current_user)
  end
end
