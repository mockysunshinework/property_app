class PropertiesController < ApplicationController
  before_action :set_property, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]
  before_action :require_admin!, except: %i[index show]

  def index
    @properties = Property.with_attached_images.order(created_at: :desc)
  end

  def show
  end

  def new
    @property = Property.new
  end

  def create
    @property = Property.new(property_params.except(:images))

    if @property.save
      @property.images.attach(property_params[:images]) if property_params[:images].present?
      redirect_to property_path(@property), notice: "物件を登録しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @property.update(property_params.except(:images))
      @property.images.attach(property_params[:images]) if property_params[:images].present?
      redirect_to property_path(@property), notice: "物件を更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @property.destroy
    redirect_to properties_path, notice: "物件を削除しました。"
  end

  private

  def set_property
    @property = Property.with_attached_images.find(params[:id])
  end

  def require_admin!
    return if current_user&.admin?

    redirect_to properties_path, alert: "管理者のみアクセスできます。"
  end

  def property_params
    params.require(:property).permit(:name, :address, :price, :description, :nearest_station, :minutes_by_walk, images: [])
  end
end
