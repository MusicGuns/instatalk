class CreateOnlines < ActiveRecord::Migration[5.1]
  def change
    create_table :onlines do |t|
      t.references :user, foreign_key: true
      t.references :room, foreign_key: true
      t.string :online

      t.timestamps
    end
  end
end
