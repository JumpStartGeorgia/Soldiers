class RootController < ApplicationController

  def index
    @soldiers = Soldier.sorted
    @total_dead = @soldiers.length
    
    load_chart_gon

  end



protected

  def load_chart_gon
    # country
    gon.country_title = I18n.t('summary.titles.country')
    gon.country_data = Soldier.summary_country_died

    # gender
    gon.gender_title = I18n.t('summary.titles.gender')
    gon.gender_data = Soldier.summary_gender

    # age
    gon.age_title = I18n.t('summary.titles.age')
    gon.age_data = Soldier.summary_age

    # date died
    gon.date_died_title = I18n.t('summary.titles.date_died')
    gon.date_died_data = Soldier.summary_date_died

    # rank
    gon.rank_title = I18n.t('summary.titles.rank')
    gon.rank_data = Soldier.summary_rank

    # served with
    gon.served_with_title = I18n.t('summary.titles.served_with')
    gon.served_with_data = Soldier.summary_served_with

    # incidents
    gon.incidents_title = I18n.t('summary.titles.incidents')
    gon.incidents_data = Soldier.summary_incidents_grouped

  end
end
