class Api::V1::ResponseController < ApplicationController
  def render_success(data: nil, status: 200)
    render json: data, status: status
  end

  def render_error(message: nil, status: 422)
    render json: { message: message }, status: status
  end

  def render_unauthorized(message: nil, status: 401)
    render json: { message: message }, status: status
  end
end
