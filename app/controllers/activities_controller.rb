class ActivitiesController < ApplicationController
  before_action :set_activity, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]

  def index
    @activities = if params[:category].present? && Activity::CATEGORIES.key?(params[:category])
      Activity.where(category: params[:category]).order(created_at: :desc)
    else
      Activity.all.order(created_at: :desc)
    end
    @current_category = params[:category]
  end

  def show
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      redirect_to @activity, notice: "Activité créée avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @activity.update(activity_params)
      redirect_to @activity, notice: "Activité modifiée avec succès."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @activity.destroy
    redirect_to activities_path, notice: "Activité supprimée avec succès."
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:title, :category, :duration, :date, :notes)
  end
end