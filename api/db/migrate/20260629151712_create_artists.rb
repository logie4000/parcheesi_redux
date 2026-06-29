class CreateArtists < ActiveRecord::Migration[8.1]
  def change
    create_table :artists do |t|
      t.string :name
      t.string :comment

      t.timestamps
    end
  end
end
