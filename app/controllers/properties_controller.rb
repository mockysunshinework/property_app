class PropertiesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :require_admin!, except: %i[index show]

  def index
    @properties = Property.with_attached_images.order(created_at: :desc)
  end

  def show
    @property = Property.with_attached_images.find(params[:id])
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params)
    if @property.save
      redirect_to property_path(@property), notice: "物件を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def require_admin!
    return if current_user&.admin?

    redirect_to properties_path, alert: "管理者のみアクセスできます。"
  end

  def property_params
    params.require(:property).permit(:name, :address, :price, :description, :nearest_station, :minutes_by_walk)
  end
end
