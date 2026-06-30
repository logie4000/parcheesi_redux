class CreateTracks < ActiveRecord::Migration[8.1]
  def change
    create_table :tracks, if_not_exists: true do |t|
      t.integer :ordinal
      t.references :radio_show, foreign_key: true
      t.references :song, foreign_key: true

      t.timestamps
    end
  end
end
