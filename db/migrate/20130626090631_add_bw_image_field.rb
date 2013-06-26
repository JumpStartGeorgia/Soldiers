class AddBwImageField < ActiveRecord::Migration
  def change
    add_column :soldiers, :img_bw_file_name, :string
    add_column :soldiers, :img_bw_content_type, :string
    add_column :soldiers, :img_bw_file_size, :integer
    add_column :soldiers, :img_bw_updated_at, :datetime
  end
end
