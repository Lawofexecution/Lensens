class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.string :status
      t.references :client, foreign_key: { to_table: :users }
      t.references :creator, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
