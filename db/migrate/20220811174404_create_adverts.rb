class CreateAdverts < ActiveRecord::Migration[7.0]
  def change
    create_table :adverts do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :type_id
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
