class AddImages < ActiveRecord::Migration
  def change
    add_column :soldiers, :img_file_name, :string
    add_column :soldiers, :img_content_type, :string
    add_column :soldiers, :img_file_size, :integer
    add_column :soldiers, :img_updated_at, :datetime
  end
end
