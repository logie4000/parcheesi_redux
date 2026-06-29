class CreateDeeJays < ActiveRecord::Migration[8.1]
  def change
    create_table :dee_jays do |t|
      t.string :name
      t.string :email
      t.string :mixcloud_user

      t.timestamps
    end
  end
end
