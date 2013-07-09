class RootController < ApplicationController
  require 'utf8_converter'

  BOM = "\uFEFF" #Byte Order Mark

  def index
    @soldiers = Soldier.sorted
    

    respond_to do |format|
      format.html { 
        @total_dead = @soldiers.length
        @last_update = Soldier.last_update
        load_chart_gon
        load_map_gon
        gon.app_name = I18n.t('app.common.app_name')
        gon.root_url = root_url
        gon.abbrv_month_names = I18n.t("date.abbr_month_names")

        render :layout => 'application_root' 
      }
      format.json { render json: @soldiers }
      format.csv { 

        data = CSV.generate() do |csv|
          # column headers
          model_class = Soldier
          model_class_tr = SoldierTranslation
          row = []      
          row << I18n.t('activerecord.attributes.soldier_translation.first_name')
          row << I18n.t('activerecord.attributes.soldier_translation.last_name')
          row << I18n.t('activerecord.attributes.soldier.gender')
          row << I18n.t('activerecord.attributes.soldier.born_at')
          row << I18n.t('activerecord.attributes.soldier_translation.from')
          row << I18n.t('activerecord.attributes.soldier_translation.rank')
          row << I18n.t('activerecord.attributes.soldier_translation.served_with')
          row << I18n.t('activerecord.attributes.soldier_translation.country_died')
          row << I18n.t('activerecord.attributes.soldier_translation.place_died')
          row << I18n.t('activerecord.attributes.soldier_translation.incident_type')
          row << I18n.t('activerecord.attributes.soldier_translation.incident_description')
          row << I18n.t('activerecord.attributes.soldier.died_at')
          row << I18n.t('activerecord.attributes.soldier.age')
          csv << row

          @soldiers.each do |soldier|
            row = []
            row << soldier.first_name
            row << soldier.last_name
            row << soldier.gender
            row << soldier.born_at
            row << soldier.place_from
            row << soldier.rank
            row << soldier.served_with
            row << soldier.country_died
            row << soldier.place_died
            row << soldier.incident_type
            row << soldier.incident_description
            row << soldier.died_at
            row << soldier.age
            csv << row
          end
        end

        filename = Utf8Converter.generate_permalink(I18n.t('app.common.app_name') + "_" + Time.now.strftime('%F_%R'))
        send_data BOM + data,
         :type => 'text/csv; charset=iso-8859-1; header=present',
         :disposition => "attachment; filename=#{filename}.csv" 
      }
    end

  end



protected

  def load_map_gon
    # georgia
#    json = JSON.parse(File.open("#{Rails.root}/public/georgia_regions_#{I18n.locale}.json", "r") {|f| f.read()})
    json = JSON.parse(File.open("#{Rails.root}/public/georgia.json", "r") {|f| f.read()})
    gon.map_georgia = json

    # afghan
    json = JSON.parse(File.open("#{Rails.root}/public/afghan.json", "r") {|f| f.read()})
    gon.map_afghan = json

    # iraq
    json = JSON.parse(File.open("#{Rails.root}/public/iraq.json", "r") {|f| f.read()})
    gon.map_iraq = json
  
  end

  def load_chart_gon
    # text for print and export buttons in highcharts
    gon.highcharts_downloadPNG = t('highcharts.downloadPNG')
    gon.highcharts_downloadJPEG = t('highcharts.downloadJPEG')
    gon.highcharts_downloadPDF = t('highcharts.downloadPDF')
    gon.highcharts_downloadSVG = t('highcharts.downloadSVG')
    gon.highcharts_printChart = t('highcharts.printChart')

    # gender
    gon.gender_title = I18n.t('summary.titles.gender')
    x = Soldier.summary_gender
    if x.present?
      gon.gender_headers = x["headers"]
      gon.gender_values = x["values"]
    end

    # age
    gon.age_title = I18n.t('summary.titles.age')
    x = Soldier.summary_age
    if x.present?
      gon.age_headers = x["headers"]
      gon.age_values = x["values"]
    end

    # country
    gon.country_title = I18n.t('summary.titles.country')
    x = Soldier.summary_country_died
    if x.present?
      gon.country_headers = x["headers"]
      gon.country_values = x["values"]
    end
  
    # date died
    gon.date_died_title = I18n.t('summary.titles.date_died')
    x = Soldier.summary_date_died
    if x.present?
      gon.date_died_headers = x["headers"]
      gon.date_died_values = x["values"]
    end

    # date died filtered
    x = Soldier.summary_date_died_filtered
    if x.present?
      gon.date_died_filtered = x
    end

    # rank
    gon.rank_title = I18n.t('summary.titles.rank')
    x = Soldier.summary_rank
    if x.present?
      gon.rank_headers = x["headers"]
      gon.rank_values = x["values"]
    end

    # served with
    gon.served_with_title = I18n.t('summary.titles.served_with')
    x = Soldier.summary_served_with
    if x.present?
      gon.served_with_headers = x["headers"]
      gon.served_with_values = x["values"]
    end

    # incident description
    gon.incident_description_title = I18n.t('summary.titles.incident_description')
    x = Soldier.summary_incident_description
    if x.present?
      gon.incident_description_headers = x["headers"]
      gon.incident_description_values = x["values"]
    end
=begin
    # incidents
    x = Soldier.summary_incidents_grouped
    if x.present?
      @num_incidents = x.length
      gon.incidents_num = x.length
      gon.incident_types = []
      for i in 0..x.length-1
        h = Hash.new
        gon.incident_types << h
        h[:title] = x[i]["header"]
        h[:headers] = x[i]["items"]["headers"]
        h[:values] = x[i]["items"]["values"]
      end
    end
=end
  end
end
