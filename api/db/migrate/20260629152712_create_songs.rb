class CreateSongs < ActiveRecord::Migration[8.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :comment
      t.references :album, null: false, foreign_key: true
      t.integer :total_plays
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
