class AddPostalCodeToSitio < ActiveRecord::Migration
  def change
    add_column :sitios, :postal_code, :string
  end
end
