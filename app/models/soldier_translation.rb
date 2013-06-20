class SoldierTranslation < ActiveRecord::Base
	require 'utf8_converter'
  has_permalink :create_permalink

	belongs_to :soldier

  attr_accessible :soldier_id, :locale, 
    :first_name, 
    :last_name, 
    :from,
    :rank,
    :served_with,
    :country_died,
    :place_died,
    :incident_type,
    :incident_description,
    :permalink


  validates :first_name, :last_name, :permalink, :presence => true


  def create_permalink
    Utf8Converter.convert_ka_to_en(self.first_name + " " + self.last_name) if self.first_name && self.last_name
  end
end
