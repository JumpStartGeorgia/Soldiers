class ChangeFromName < ActiveRecord::Migration
  def up
    remove_index :soldier_translations, :from
    rename_column  :soldier_translations, :from, :place_from
    add_index :soldier_translations, :place_from
  end

  def down
    remove_index :soldier_translations, :place_from
    rename_column  :soldier_translations, :place_from, :from
    add_index :soldier_translations, :from
  end
end
