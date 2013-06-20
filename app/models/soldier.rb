class Soldier < ActiveRecord::Base
	translates :permalink, :first_name, :last_name, :from, :rank, :served_with, :country_died, :place_died, :incident_type, :incident_description

	has_many :soldier_translations, :dependent => :destroy
  accepts_nested_attributes_for :soldier_translations
  attr_accessible :soldier_translations_attributes,
      :born_at,
      :died_at,
      :age, 
      :is_male

  validates :died_at, :presence => true


  ######################
  ## load from json
  ## - expect each item to have key names that match attr names
  ######################
  def self.load_from_json(en_json, ka_json)
    if en_json.present? && ka_json.present?
      Soldier.transaction do
        en_json.each_with_index do |record, index|
          puts index

          # get ka record
          ka_record = ka_json.select{|x| x["id"] == record["id"]}.first

          s = Soldier.new(:born_at => record["born_at"], :died_at => record["died_at"], :age => record["age"])
          if s.save
            s.soldier_translations.create(:locale => 'en', :first_name => record["first_name"], :last_name => record["last_name"],
              :from => record["from"], :rank => record["rank"], :served_with => record["served_with"], 
              :country_died => record["country_died"], :place_died => record["place_died"], 
              :incident_type => record["incident_type"], :incident_description => record["incident_description"])

            if ka_record.present?
              s.soldier_translations.create(:locale => 'ka', :first_name => ka_record["first_name"], :last_name => ka_record["last_name"],
                :from => ka_record["from"], :rank => ka_record["rank"], :served_with => ka_record["served_with"], 
                :country_died => ka_record["country_died"], :place_died => ka_record["place_died"], 
                :incident_type => ka_record["incident_type"], :incident_description => ka_record["incident_description"])
            else
puts "----------- - could not find ka match for #{record["id"]}"
              s.soldier_translations.create(:locale => 'en', :first_name => record["first_name"], :last_name => record["last_name"],
                :from => record["from"], :rank => record["rank"], :served_with => record["served_with"], 
                :country_died => record["country_died"], :place_died => record["place_died"], 
                :incident_type => record["incident_type"], :incident_description => record["incident_description"])
            end
          else
            puts "****************************"
            puts s.errors.full_messages
          end
        end
      end
    end
  end
end
