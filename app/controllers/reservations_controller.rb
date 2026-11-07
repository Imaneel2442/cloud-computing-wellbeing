class ReservationsController < ApplicationController
  before_action :require_login

  def index
    @reservations = current_user.reservations.includes(:activity).order(created_at: :desc)
  end

  def create
    @activity = Activity.find(params[:activity_id])
    @reservation = @activity.reservations.new(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to reservations_path, notice: "Réservation confirmée !"
    else
      redirect_to @activity, alert: @reservation.errors.full_messages.join(", ")
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:date, :time, :seats)
  end
end
