class Soldier < ActiveRecord::Base
	translates :permalink, :first_name, :last_name, :place_from, :rank, :served_with, :country_died, :place_died, :incident_type, :incident_description

	has_attached_file :img, :url => "/system/photo/:id/:permalink_:style.:extension",
                  :styles => { :thumb => "100x100", :medium => "200x200", :big => "300x300" }, 
                  :default_url => "/images/:style/missing.png"

	has_many :soldier_translations, :dependent => :destroy
  accepts_nested_attributes_for :soldier_translations
  attr_accessible :soldier_translations_attributes,
      :born_at,
      :died_at,
      :age, 
      :is_male, 
      :img,
      :img_file_name,
      :img_content_type,
      :img_file_size,
      :img_updated_at

  validates :died_at, :presence => true

  ######################
  ## summary queries
  ## all formats are [{key, value}, {key, value}, {key, value}....]
  ######################

  # gender
  def self.summary_gender
    h = []
    x = Soldier.count(:group => :is_male)

    y = Hash.new
    h << y
    y[:key] = I18n.t('summary.male')
    y[:value] = x.has_key?(true).present? ? x[true] : 0

    y = Hash.new
    h << y
    y[:key] = I18n.t('summary.female')
    y[:value] = x.has_key?(false).present? ? x[false] : 0

    return h
  end

  # date died
  def self.summary_date_died
    h = []
    x = Soldier.count(:group => :died_at)

    if x.present?
      x.keys.each do |key|
        y = Hash.new
        h << y
        y[:key] = key.strftime('%F')
        y[:value] = x[key]
      end
      h.sort_by{|y| y[:key]}
    end

    return h
  end

  # place from
  def self.summary_place_from
    x = SoldierTranslation.where(:locale => I18n.locale).count(:group => :place_from)
    return create_summary_array(x)
  end

  # rank
  def self.summary_rank
    x = SoldierTranslation.where(:locale => I18n.locale).count(:group => :rank)
    return create_summary_array(x)
  end

  # served with
  def self.summary_served_with
    x = SoldierTranslation.where(:locale => I18n.locale).count(:group => :served_with)
    return create_summary_array(x)
  end

  # country died
  def self.summary_country_died
    x = SoldierTranslation.where(:locale => I18n.locale).count(:group => :country_died)
    return create_summary_array(x)
  end

  # place died
  def self.summary_place_died
    x = SoldierTranslation.where(:locale => I18n.locale).count(:group => :place_died)
    return create_summary_array(x)
  end

  # incident type
  def self.summary_incident_type
    x = SoldierTranslation.where(:locale => I18n.locale).count(:group => :incident_type)
    return create_summary_array(x)
  end

  # incident desc
  def self.summary_incident_description
    x = SoldierTranslation.where(:locale => I18n.locale).count(:group => :incident_description)
    return create_summary_array(x)
  end



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
              :place_from => record["place_from"], :rank => record["rank"], :served_with => record["served_with"], 
              :country_died => record["country_died"], :place_died => record["place_died"], 
              :incident_type => record["incident_type"], :incident_description => record["incident_description"])

            if ka_record.present?
              s.soldier_translations.create(:locale => 'ka', :first_name => ka_record["first_name"], :last_name => ka_record["last_name"],
                :place_from => ka_record["place_from"], :rank => ka_record["rank"], :served_with => ka_record["served_with"], 
                :country_died => ka_record["country_died"], :place_died => ka_record["place_died"], 
                :incident_type => ka_record["incident_type"], :incident_description => ka_record["incident_description"])
            else
puts "********************************"
puts "----------- - could not find ka match for #{record["id"]}"
              s.soldier_translations.create(:locale => 'en', :first_name => record["first_name"], :last_name => record["last_name"],
                :place_from => record["place_from"], :rank => record["rank"], :served_with => record["served_with"], 
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

protected

  def self.create_summary_array(data)
    h = []

    if data.present?
      data.keys.each do |key|
        y = Hash.new
        h << y
        y[:key] = key.nil? ? I18n.t('summary.unknown') : key
        y[:value] = data[key]
      end
      h.sort_by{|y| y[:key]}
    end

    return h
  end
end
