class RenameTypeIdTypeAdToAdverts < ActiveRecord::Migration[7.0]
  def change
    rename_column :adverts, :type_id, :type_ad
  end
end
