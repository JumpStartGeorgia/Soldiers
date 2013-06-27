class RootController < ApplicationController

  def index
    @soldiers = Soldier.sorted
    @total_dead = @soldiers.length

    @last_update = Soldier.last_update
    
    load_chart_gon

    render :layout => 'application_root'

  end



protected

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
      gon.gender_headers = x[:headers]
      gon.gender_values = x[:values]
    end

    # age
    gon.age_title = I18n.t('summary.titles.age')
    x = Soldier.summary_age
    if x.present?
      gon.age_headers = x[:headers]
      gon.age_values = x[:values]
    end

    # country
    gon.country_title = I18n.t('summary.titles.country')
    x = Soldier.summary_country_died
    if x.present?
      gon.country_headers = x[:headers]
      gon.country_values = x[:values]
    end
  
    # date died
    gon.date_died_title = I18n.t('summary.titles.date_died')
    x = Soldier.summary_date_died
    if x.present?
      gon.date_died_headers = x[:headers]
      gon.date_died_values = x[:values]
    end

    # rank
    gon.rank_title = I18n.t('summary.titles.rank')
    x = Soldier.summary_rank
    if x.present?
      gon.rank_headers = x[:headers]
      gon.rank_values = x[:values]
    end

    # served with
    gon.served_with_title = I18n.t('summary.titles.served_with')
    x = Soldier.summary_served_with
    if x.present?
      gon.served_with_headers = x[:headers]
      gon.served_with_values = x[:values]
    end

    # incidents
    x = Soldier.summary_incidents_grouped
    if x.present?
      @num_incidents = x.length
      gon.incidents_num = x.length
      gon.incident_types = []
      for i in 0..x.length-1
        h = Hash.new
        gon.incident_types << h
        h[:title] = x[i][:header]
        h[:headers] = x[i][:items][:headers]
        h[:values] = x[i][:items][:values]
      end
    end

  end
end
