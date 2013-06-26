class Soldier < ActiveRecord::Base
	translates :permalink, :first_name, :last_name, :place_from, :rank, :served_with, :country_died, :place_died, :incident_type, :incident_description

	has_attached_file :img, :url => "/system/photo/:id/:permalink.:extension",
                  :default_url => "/images/missing.png"

	has_attached_file :img_bw, :url => "/system/photo/:id/:permalink_bw.:extension",
                  :default_url => "/images/missing_bw.png"

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
      :img_updated_at,
      :img_bw,
      :img_bw_file_name,
      :img_bw_content_type,
      :img_bw_file_size,
      :img_bw_updated_at

  validates :died_at, :presence => true

  def self.sorted
    with_translations(I18n.locale).order("soldiers.id asc")
  end

  def full_name
    self.first_name.strip() + " " + self.last_name.strip()
  end

  def gender
    if self.is_male 
      I18n.t('summary.male') 
    else 
      I18n.t('summary.female') 
    end 
  end

  # total dead
  def self.total_dead
    h = []
    x = Soldier.count()

    y = Hash.new
    h << y
    h[:headers] << I18n.t('summary.total')
    h[:values] << x

    return h
  end

  ######################
  ## summary queries
  ## all formats are { headers => [], values => []}
  ######################
  # gender
  def self.summary_gender
    h = Hash.new
    h[:headers] = []
    h[:values] = []
    x = Soldier.count(:group => :is_male)

    h[:headers] << I18n.t('summary.male')
    h[:values] << (x.has_key?(true).present? ? x[true] : 0)

    h[:headers] << I18n.t('summary.female')
    h[:values] << (x.has_key?(false).present? ? x[false] : 0)

    return h
  end

  # age 
  # groups: 20-24, 25-29, 30-34, 35-39, 40-49
  AGE_CATEGORIES = ["20-24", "25-29", "30-34", "35-39", "40-49"]
  def self.summary_age
    h = Hash.new
    h[:headers] = []
    h[:values] = []
    h[:min] = []
    h[:max] = []
    x = Soldier.select('age')

    h[:headers] << AGE_CATEGORIES[0]
    ary = x.select{|x| x.age <= 24 && x.age >= 20}
    h[:values] << (ary.present? ? ary.length : 0)
    h[:min] << 20
    h[:max] << 24

    h[:headers] << AGE_CATEGORIES[1]
    ary = x.select{|x| x.age <= 29 && x.age >= 25}
    h[:values] << (ary.present? ? ary.length : 0)
    h[:min] << 25
    h[:max] << 29

    h[:headers] << AGE_CATEGORIES[2]
    ary = x.select{|x| x.age <= 34 && x.age >= 30}
    h[:values] << (ary.present? ? ary.length : 0)
    h[:min] << 30
    h[:max] << 34

    h[:headers] << AGE_CATEGORIES[3]
    ary = x.select{|x| x.age <= 39 && x.age >= 35}
    h[:values] << (ary.present? ? ary.length : 0)
    h[:min] << 35
    h[:max] << 39

    h[:headers] << AGE_CATEGORIES[4]
    ary = x.select{|x| x.age <= 49 && x.age >= 40}
    h[:values] << (ary.present? ? ary.length : 0)
    h[:min] << 40
    h[:max] << 49

    return h
  end

  # date died
  def self.summary_date_died
    h = Hash.new
    h[:headers] = []
    h[:values] = []
    x = Soldier.select("died_at").group_by{|x| x.died_at.beginning_of_month}
    start_year = 2007
    end_year = Time.now.year

    if x.present?
      dates = []
      x.keys.each do |key|
        dates << {:month => key.month, :year => key.year, :count => x[key].count}
      end
  
      for i in start_year..end_year
        for j in 1..12
          h[:headers] << "#{i} #{Date::MONTHNAMES[j]}"
          date = dates.select{|x| x[:month] == j && x[:year] == i}
          h[:values] << (date.present? ? date.first[:count] : nil)

          # if this is the current month/year, stop
          break if i==end_year && j==Time.now.month
        end
      end
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

  # for each incident type, get summary of incident descriptions
  # format: [{header value items => {headers values}}, {header value items => {headers values}}, etc]
  def self.summary_incidents_grouped
    h = []
    x = summary_incident_type

    if x.present?
      for i in 0..x[:headers].length-1
        z = Hash.new
        h << z
        z[:header] = x[:headers][i]
        z[:value] = x[:values][i]
        a = SoldierTranslation.where(:locale => I18n.locale, :incident_type => z[:header]).count(:group => :incident_description)
        z[:items] = create_summary_array(a)
      end
    end

    return h
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
    h = Hash.new
    h[:headers] = []
    h[:values] = []

    if data.present?
      data.keys.each do |key|
        h[:headers] << (key.nil? ? I18n.t('summary.unknown') : key)
        h[:values] << data[key]
      end
#      h.sort_by{|y| y[:key]}
    end

    return h
  end
end
