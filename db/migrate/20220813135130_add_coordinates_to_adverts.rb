class AddCoordinatesToAdverts < ActiveRecord::Migration[7.0]
  def change
    add_column :adverts, :latitude, :float
    add_column :adverts, :longitude, :float
  end
end
