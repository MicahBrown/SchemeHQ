module DashboardHelper
  def dashboard_link icon_name, value, tab_id, options={}
    options = options.deep_merge({ title: value, data: { tooltip: "", template_classes: "hide-for-medium" } })
    value   = icon icon_name, content_tag(:span, value, class: "show-for-medium"), class: "fa-fw"

    link_to value, tab_id, options
  end
end