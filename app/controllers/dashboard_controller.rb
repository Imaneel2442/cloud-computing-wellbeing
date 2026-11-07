class DashboardController < ApplicationController
  before_action :require_login

  def index
    @stats = {
      activities_count: Activity.count,
      reservations_count: current_user.reservations.count,
      avg_rating: 0
    }

    @upcoming = current_user.reservations
                            .includes(:activity)
                            .where("date >= ?", Date.today)
                            .order(:date)
                            .limit(5)
  end
end
