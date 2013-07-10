# encoding: utf-8
class Soldier < ActiveRecord::Base
	require 'json'
  require 'json_cache'

	translates :permalink, :first_name, :last_name, :place_from, :region_from, :rank, :served_with, :country_died, :place_died, :incident_type, :incident_description, :region_from

	has_attached_file :img, :url => "/system/photo/:id/:permalink.:extension",
                  :default_url => "/assets/missing.jpg"

	has_attached_file :img_bw, :url => "/system/photo/:id/:permalink_bw.:extension",
                  :default_url => "/assets/missing_bw.jpg"

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

  CACHE_KEY_GENDER = "[locale]/gender"
  CACHE_KEY_AGE = "[locale]/age"
  CACHE_KEY_COUNTRY_DIED = "[locale]/country_died"
  CACHE_KEY_PLACE_DIED = "[locale]/place_died"
  CACHE_KEY_RANK = "[locale]/rank"
  CACHE_KEY_SERVED_WITH = "[locale]/served_with"
  CACHE_KEY_INCIDENT_TYPE = "[locale]/incident_type"
  CACHE_KEY_INCIDENT_DESCRIPTION = "[locale]/incident_description"
  CACHE_KEY_INCIDENTS = "[locale]/incidents"
  CACHE_KEY_DATE_DIED = "[locale]/date_died"
  CACHE_KEY_DATE_DIED_FILTERED = "[locale]/date_died_filtered"
  CACHE_KEY_PLACE_FROM = "[locale]/place_from"
  CACHE_KEY_REGION_FROM = "[locale]/region_from"
  CACHE_KEY_LAST_UPDATED = "[locale]/last_updated"

  def self.sorted
    with_translations(I18n.locale).order("soldiers.died_at DESC, soldier_translations.last_name ASC")
  end

  def self.last_update
		h = JsonCache.fetch(CACHE_KEY_LAST_UPDATED.gsub("[locale]", I18n.locale.to_s)) {
      z = []
      x = select('created_at').order('created_at desc').limit(1)
      if x.present?
        z << I18n.l(x.first.created_at, :format => :no_time)
      end
      z.to_json
    }
    return JSON.parse(h).first
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

  # the image uses the permalink value which can be different for each langauge
  # use the ka value as the common permalink
  def common_permalink
    self.soldier_translations.select{|x| x.locale == "ka"}.first.permalink
  end

  ######################
  ## summary queries
  ## all formats are { headers => [], values => []}
  ######################
  # gender
  def self.summary_gender
		h = JsonCache.fetch(CACHE_KEY_GENDER.gsub("[locale]", I18n.locale.to_s)) {
      h = Hash.new
      h[:headers] = []
      h[:values] = []
      x = Soldier.count(:group => :is_male)

      h[:headers] << I18n.t('summary.male')
      h[:values] << (x.has_key?(true).present? ? x[true] : 0)

      h[:headers] << I18n.t('summary.female')
      h[:values] << (x.has_key?(false).present? ? x[false] : 0)
      h.to_json
    }
    return JSON.parse(h)
  end

  # age 
  # groups: 20-24, 25-29, 30-34, 35-39, 40-49
  AGE_CATEGORIES = ["20-24", "25-29", "30-34", "35-39", "40-49"]
  def self.summary_age
		h = JsonCache.fetch(CACHE_KEY_AGE.gsub("[locale]", I18n.locale.to_s)) {
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

      h.to_json
    }
    return JSON.parse(h)
  end

  # date died
  def self.summary_date_died
		h = JsonCache.fetch(CACHE_KEY_DATE_DIED.gsub("[locale]", I18n.locale.to_s)) {
      h = Hash.new
      h[:headers] = []
      h[:values] = []
      x = Soldier.select("died_at").group_by{|x| x.died_at.beginning_of_month}
      start_year = 2004
      end_year = Time.now.year

      if x.present?
        dates = []
        x.keys.each do |key|
          dates << {:month => key.month, :year => key.year, :count => x[key].count}
        end
    
        for i in start_year..end_year
          for j in 1..12
            h[:headers] << "#{i} #{I18n.t("date.abbr_month_names")[j]}"
            date = dates.select{|x| x[:month] == j && x[:year] == i}
            h[:values] << (date.present? ? date.first[:count] : nil)

            # if this is the current month/year, stop
            break if i==end_year && j==Time.now.month
          end
        end
      end
      h.to_json
    }

    return JSON.parse(h)
  end

  # date died filtered
  # just get unique dates that have deaths
  def self.summary_date_died_filtered
		h = JsonCache.fetch(CACHE_KEY_DATE_DIED_FILTERED.gsub("[locale]", I18n.locale.to_s)) {
      Soldier.select("died_at").order("died_at").group_by{|x| x.died_at.beginning_of_month}.map{|x| x[0]}.to_json
    }
    return JSON.parse(h)
  end

  # place from
  def self.summary_place_from
		h = JsonCache.fetch(CACHE_KEY_PLACE_FROM.gsub("[locale]", I18n.locale.to_s)) {
      x = Hash[SoldierTranslation.where(:locale => I18n.locale).count(:group => :place_from).sort_by{|k,v| -v}]
      create_summary_array_with_classes(x).to_json
    }
    return JSON.parse(h)
  end

  # region from
  def self.summary_region_from
		h = JsonCache.fetch(CACHE_KEY_REGION_FROM.gsub("[locale]", I18n.locale.to_s)) {
      x = Hash[SoldierTranslation.where(:locale => I18n.locale).count(:group => :region_from).sort_by{|k,v| -v}]
      create_summary_array_with_classes(x).to_json
    }
    return JSON.parse(h)
  end

  # rank
  RANK_ORDER_EN = ['Colonel', 'Lieutenant', 'Sergeant', 'Junior Sergeant', 'Corporal', 'Private 1st Class', 'Private']
  RANK_ORDER_KA = ['პოლკოვნიკი', 'ლეიტენანტი', 'სერჟანტი', 'უმცროსი სერჟანტი', 'კაპრალი', 'პირველი კლასის რიგითი', 'რიგითი']
  def self.summary_rank
		h = JsonCache.fetch(CACHE_KEY_RANK.gsub("[locale]", I18n.locale.to_s)) {
      x = SoldierTranslation.where(:locale => I18n.locale).count(:group => :rank)
      # build a new hash in the correct rank order
      r = Hash.new
      ary = I18n.locale == :en ? RANK_ORDER_EN : RANK_ORDER_KA
      ary.each do |a|
        count = x.select{|k,v| k == a}.map{|k,v| v}

        r[a] = count.present? ? count.first : 0
      end

      create_summary_array(r).to_json
    }
    return JSON.parse(h)
  end

  # served with
  def self.summary_served_with
		h = JsonCache.fetch(CACHE_KEY_SERVED_WITH.gsub("[locale]", I18n.locale.to_s)) {
      x = Hash[SoldierTranslation.where(:locale => I18n.locale).count(:group => :served_with).sort_by{|k,v| -v}]
      create_summary_array(x).to_json
    }
    return JSON.parse(h)
  end

  # country died
  def self.summary_country_died
		h = JsonCache.fetch(CACHE_KEY_COUNTRY_DIED.gsub("[locale]", I18n.locale.to_s)) {
      x = Hash[SoldierTranslation.where(:locale => I18n.locale).count(:group => :country_died).sort_by{|k,v| -v}]
      create_summary_array(x).to_json
    }
    return JSON.parse(h)
  end

  # place died
  def self.summary_place_died
		h = JsonCache.fetch(CACHE_KEY_PLACE_DIED.gsub("[locale]", I18n.locale.to_s)) {
      x = Hash[SoldierTranslation.where(:locale => I18n.locale).count(:group => :place_died).sort_by{|k,v| -v}]
      create_summary_array_with_classes(x).to_json
    }
    return JSON.parse(h)
  end

  # incident type
  def self.summary_incident_type
		h = JsonCache.fetch(CACHE_KEY_INCIDENT_TYPE.gsub("[locale]", I18n.locale.to_s)) {
      x = Hash[SoldierTranslation.where(:locale => I18n.locale).count(:group => :incident_type).sort_by{|k,v| -v}]
      create_summary_array(x).to_json
    }
    return JSON.parse(h)
  end

  # incident desc
  def self.summary_incident_description
		h = JsonCache.fetch(CACHE_KEY_INCIDENT_DESCRIPTION.gsub("[locale]", I18n.locale.to_s)) {
      x = Hash[SoldierTranslation.where(:locale => I18n.locale).count(:group => :incident_description).sort_by{|k,v| -v}]
      create_summary_array(x).to_json
    }
    return JSON.parse(h)
  end

  # for each incident type, get summary of incident descriptions
  # format: [{header value items => {headers values}}, {header value items => {headers values}}, etc]
  def self.summary_incidents_grouped
		h = JsonCache.fetch(CACHE_KEY_INCIDENTS.gsub("[locale]", I18n.locale.to_s)) {
      h = []
      x = summary_incident_type

      if x.present?
        for i in 0..x["headers"].length-1
          z = Hash.new
          h << z
          z[:header] = x["headers"][i]
          z[:value] = x["values"][i]
          a = Hash[SoldierTranslation.where(:locale => I18n.locale, :incident_type => z[:header]).count(:group => :incident_description).sort_by{|k,v| -v}]
          z[:items] = create_summary_array(a)
        end
      end
      h.to_json
    }

    return JSON.parse(h)
  end

  ######################
  ## load from json
  ## - expect each item to have key names that match attr names
  ######################
  def self.load_from_json(en_json, ka_json, color_image_path=nil, bw_image_path=nil)
    if en_json.present? && ka_json.present?
      has_images = false
puts "color = #{color_image_path}"
puts "bw = #{bw_image_path}"

      # get path to images
      if color_image_path.present? && bw_image_path.present? && Dir.exists?(color_image_path) && Dir.exists?(bw_image_path)
puts "found images"
        has_images = true
      end

      Soldier.transaction do
        en_json.each_with_index do |record, index|
          puts index

          color_image_file = nil
          bw_image_file = nil

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

            # add images
            # must have both images in order to add
            if has_images
  puts "- trying to add images"
              # find color image
              color = Dir.glob(color_image_path + "/" + record["id"] + ".*")

              # find bw image
              bw = Dir.glob(bw_image_path + "/" + record["id"] + ".*")

              if color.present? && bw.present?
  puts "- found color and bw; adding"
                color_image_file = File.open(color.first)
                bw_image_file = File.open(bw.first)
                s.img = color_image_file
                s.img_bw = bw_image_file
                s.save
              end

              # close the files if they are open
              color_image_file.close if color_image_file.present?
              bw_image_file.close if bw_image_file.present?
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
    end

    return h
  end

  def self.create_summary_array_with_classes(data)
    h = Hash.new
    h[:headers] = []
    h[:values] = []
    h[:css_classes] = []

    if data.present?
      data.keys.each do |key|
        h[:headers] << (key.nil? ? I18n.t('summary.unknown') : key)
        h[:values] << data[key]
        h[:css_classes] << case data[key]
          when 0
            "map_color0"
          when 1
            "map_color1"
          when 2
            "map_color2"
          when 3..6
            "map_color3"
          when 7..10
            "map_color4"
          else
            "map_color5"
=begin
          when 0
            "map_color0"
          when 1
            "map_color1"
          when 2
            "map_color2"
          when 3
            "map_color3"
          when 4
            "map_color4"
          when 5
            "map_color5"
          when 6
            "map_color6"
          when 7
            "map_color7"
          when 8
            "map_color8"
          when 9
            "map_color9"
          else
            "map_color10"
=end        
        end
      end
    end

    return h
  end
end
