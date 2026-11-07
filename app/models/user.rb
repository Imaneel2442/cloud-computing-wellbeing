class User < ApplicationRecord
  has_secure_password
  has_many :reservations, dependent: :destroy

  validates :name, presence: { message: "Le nom est obligatoire" }
  validates :email, presence: { message: "L'email est obligatoire" },
                    uniqueness: { message: "Cet email est déjà utilisé" }
end