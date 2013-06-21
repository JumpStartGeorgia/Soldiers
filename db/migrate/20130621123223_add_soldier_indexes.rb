class AddSoldierIndexes < ActiveRecord::Migration
  def change
    add_index :soldiers, :died_at
    add_index :soldier_translations, :from
    add_index :soldier_translations, :rank
    add_index :soldier_translations, :served_with
    add_index :soldier_translations, :country_died
    add_index :soldier_translations, :place_died
    add_index :soldier_translations, :incident_type
    add_index :soldier_translations, :incident_description
  end
end
