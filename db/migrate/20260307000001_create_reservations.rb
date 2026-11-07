class CreateReservations < ActiveRecord::Migration[7.1]
  def change
    create_table :reservations do |t|
      t.references :activity, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date    :date,        null: false
      t.string  :time,        null: false
      t.integer :seats,       null: false, default: 1
      t.decimal :total_price, precision: 10, scale: 2
      t.string  :status,      null: false, default: "confirmed"

      t.timestamps
    end
  end
end
