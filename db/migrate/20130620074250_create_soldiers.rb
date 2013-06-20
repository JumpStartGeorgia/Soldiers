class CreateSoldiers < ActiveRecord::Migration
  def up
    create_table :soldiers do |t|
      t.string :born_at
      t.date :died_at
      t.integer :age

      t.timestamps
    end

    Soldier.create_translation_table! :first_name => :string, 
      :last_name => :string, 
      :from => :string,
      :rank => :string,
      :served_with => :string,
      :country_died => :string,
      :place_died => :string,
      :incident_type => :string,
      :incident_description => :string,
      :permalink => :string

  end

  def down
    Soldier.drop_translation_table!
    drop_table :soldiers

  end
end
