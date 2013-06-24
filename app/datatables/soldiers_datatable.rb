class SoldiersDatatable
  include Rails.application.routes.url_helpers
  delegate :params, :h, :link_to, :number_to_currency, :image_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Soldier.with_translations(I18n.locale).count,
      iTotalDisplayRecords: soldiers.total_entries,
      aaData: data
    }
  end

private

  def data
    soldiers.map do |soldier|
      [
        link_to(I18n.t('helpers.links.view'), admin_soldier_path(:id => soldier.id, :locale => I18n.locale), :class => 'btn btn-mini'),
        photo_name(soldier),
        soldier.rank,
        soldier.served_with,
        soldier.country_died,
        soldier.place_died,
        soldier.incident_type,
        soldier.incident_description,
        soldier.died_at,
        action_links(soldier)
      ]
    end
  end

  def photo_name(soldier)
    x = "#{soldier.last_name}, #{soldier.first_name}"
    if soldier.img_file_name.present?
      x << "<br />"
      x << image_tag(soldier.img.url, :width => '30%', :height => '30%')
    end

    return x.html_safe
  end

  def action_links(soldier)
    x = ""
    x << link_to(I18n.t("helpers.links.edit"),
                    edit_admin_soldier_path(:id => soldier.id, :locale => I18n.locale), :class => 'btn btn-mini')
    x << " "
    x << link_to(I18n.t("helpers.links.destroy"),
                    admin_soldier_path(:id => soldier.id, :locale => I18n.locale),
                    :method => :delete,
								    :data => { :confirm => I18n.t("helpers.links.confirm") },
                    :class => 'btn btn-mini btn-danger')
    x << "<br /><br />"
    x << I18n.t('app.common.added_on', :date => I18n.l(soldier.created_at, :format => :short))
    return x.html_safe
  end

  def soldiers
    @soldiers ||= fetch_soldiers
  end

  def fetch_soldiers
    soldiers = Soldier.with_translations(I18n.locale).order("#{sort_column} #{sort_direction}")
    soldiers = soldiers.page(page).per_page(per_page)
    if params[:sSearch].present?
      search_qry = "soldier_translations.first_name like :search or soldier_translations.last_name like :search or "  
      search_qry << "soldier_translations.rank like :search or soldier_translations.served_with like :search or "  
      search_qry << "soldier_translations.country_died like :search or soldier_translations.place_died like :search or "  
      search_qry << "soldier_translations.incident_type like :search or soldier_translations.incident_description like :search "  
      soldiers = soldiers.where(search_qry, search: "%#{params[:sSearch]}%")
    end
    soldiers
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[soldier_translations.last_name soldier_translations.last_name soldier_translations.rank soldier_translations.served_with soldier_translations.country_died soldier_translations.place_died soldier_translations.incident_type soldier_translations.incident_description soldiers.died_at soldiers.created_at]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
