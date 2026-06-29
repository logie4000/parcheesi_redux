class CreateSongs < ActiveRecord::Migration[8.1]
  def change
    create_table :songs do |t|
      t.string :title
      t.string :comment
      t.references :album, foreign_key: true
      t.integer :total_plays
      t.references :artist, foreign_key: true
      t.references :last_played_overall, foreign_key: { to_table: :radio_shows }

      t.timestamps
    end
  end
end
