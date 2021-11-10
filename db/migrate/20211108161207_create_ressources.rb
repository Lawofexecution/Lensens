class CreateRessources < ActiveRecord::Migration[6.1]
  def change
    create_table :ressources do |t|
      t.string :img_url
      t.string :video_url
      t.references :project
      t.timestamps
    end
  end
end
