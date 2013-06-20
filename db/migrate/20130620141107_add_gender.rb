class AddGender < ActiveRecord::Migration
  def change
    add_column :soldiers, :is_male, :boolean, :default => true
    add_index  :soldiers, :is_male
  end
end
