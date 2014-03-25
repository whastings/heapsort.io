class Api::ResourceTypesController < ApplicationController
  def index
    resource_types = ResourceType.all
    render json: resource_types
  end
end
