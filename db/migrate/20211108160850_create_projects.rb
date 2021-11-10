class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :category
      t.date :start_date
      t.date :end_date
      t.references :client, foreign_key: { to_table: :users }
      t.references :creator, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
