class PropertiesController < ApplicationController
  def index
    @properties = Property.with_attached_images.order(created_at: :desc)
  end

  def show
    @property = Property.with_attached_images.find(params[:id])
  end
end
