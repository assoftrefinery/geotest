class CreateSitios < ActiveRecord::Migration
  def change
    create_table :sitios do |t|
      t.string :titulo
      t.string :direccion
      t.text :notas
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
