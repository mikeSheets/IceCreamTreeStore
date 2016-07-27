class Api::V1::BaseController < ApplicationController

  def create
    model = resource_klass.new(strong_params)

    if model.save
      render_model(model)
    else
      render_model_errors(model)
    end
  end

  def update
    if model.update(strong_params)
      render_model(model)
    else
      render_model_errors(model)
    end
  end

  protected
  def strong_params
    method = "#{resource_name}_params"
    clean_params = send(method)
    clean_params
  end

  def model
    instance_variable_get(:"@#{resource_name}")
  end

  def resource_klass
    resource_name.classify.constantize
  end

  def resource_name
    controller_name.underscore.split('/').last.singularize
  end

  def render_model(model)
    render json: model.as_json
  end

  def render_model_errors(model)
    Rails.logger.info(model.errors.inspect) if !Rails.env.production?
    render json: model.errors, status: 400
  end
end