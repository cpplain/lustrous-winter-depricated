class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def render_success(status, data = nil)
    return render json: data, status: status if data
    head status
  end

  def render_error(status, data = nil)
    return render json: { errors: data }, status: status if data
    head status
  end
end
