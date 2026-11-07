class Reservation < ApplicationRecord
  belongs_to :activity
  belongs_to :user

  STATUSES = %w[confirmed pending cancelled].freeze

  validates :date, :time, presence: true
  validates :seats, numericality: { greater_than: 0, only_integer: true }
  validates :status, inclusion: { in: STATUSES }

  before_save :compute_total_price

  private

  def compute_total_price
    self.total_price = seats * 50
  end
end
