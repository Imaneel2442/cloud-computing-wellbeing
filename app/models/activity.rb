class Activity < ApplicationRecord
  CATEGORIES = {
    "yoga" => { label: "Yoga", emoji: "🧘", color: "#7A5AF8" },
    "marche" => { label: "Marche", emoji: "🚶", color: "#16A34A" },
    "meditation" => { label: "Méditation", emoji: "🧠", color: "#A855F7" },
    "sport" => { label: "Sport", emoji: "💪", color: "#F59E0B" },
    "soins" => { label: "Soins", emoji: "💆", color: "#EF4444" },
    "nutrition" => { label: "Nutrition", emoji: "🥗", color: "#22C55E" }
  }.freeze

  has_many :reservations, dependent: :destroy

  validates :title, presence: true
  validates :category, inclusion: { in: CATEGORIES.keys }
  validates :duration, numericality: { greater_than: 0 }, allow_nil: true

  def category_info
    CATEGORIES[category] || { label: category, emoji: "✨", color: "#7A5AF8" }
  end

  def emoji
    category_info[:emoji]
  end

  def formatted_duration
    return "-" if duration.blank?
    duration >= 60 ? "#{duration / 60}h" : "#{duration} min"
  end
end