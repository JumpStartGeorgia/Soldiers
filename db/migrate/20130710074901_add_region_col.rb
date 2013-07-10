class AddRegionCol < ActiveRecord::Migration
  def up
    add_column :soldier_translations, :region_from, :string
    add_index :soldier_translations, :region_from 
  end

  def down
    remove_index  :soldier_translations, :region_from
    remove_column :soldier_translations, :region_from
  end
end
