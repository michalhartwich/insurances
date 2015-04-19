module ApplicationHelper
  def create_menu_item(body,url,html_options={})
    active = "active" if current_page?(url)
    link_to body, url, class: 'list-group-item #{active}'
  end
end
