class CreateAlbums < ActiveRecord::Migration[8.1]
  def change
    create_table :albums, if_not_exists: true do |t|
      t.string :title
      t.text :comment

      t.timestamps
    end
  end
end
