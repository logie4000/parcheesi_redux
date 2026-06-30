class CreateRadioShows < ActiveRecord::Migration[8.1]
  def change
    create_table :radio_shows, if_not_exists: true do |t|
      t.date :publish_date
      t.string :title
      t.text :comment
      t.references :dee_jay, foreign_key: true
      t.string :web_link

      t.timestamps
    end
  end
end
