class CreateDeeJays < ActiveRecord::Migration[8.1]
  def change
    create_table :dee_jays, if_not_exists: true do |t|
      t.string :name
      t.string :email
      t.string :mixcloud_user
      t.string :password_digest
      
      t.timestamps
    end
  end
end
