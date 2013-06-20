class Soldier < ActiveRecord::Base
	translates :permalink, :first_name, :last_name, :from, :rank, :served_with, :country_died, :place_died, :incident_type, :incident_description

	has_many :soldier_translations, :dependent => :destroy
  accepts_nested_attributes_for :soldier_translations
  attr_accessible :soldier_translations_attributes,
      :born_at,
      :died_at,
      :age

  validates :died_at, :presence => true


end
