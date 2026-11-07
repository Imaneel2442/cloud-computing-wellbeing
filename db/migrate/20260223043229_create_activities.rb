class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :category
      t.integer :duration
      t.date :date
      t.text :notes

      t.timestamps
    end
  end
end
