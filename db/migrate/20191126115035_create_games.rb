class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.string :name
      t.string :rules
      t.string :photo
      t.integer :player_max

      t.timestamps
    end
  end
end
