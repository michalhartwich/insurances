module ApplicationHelper
  def create_menu_item(body,url,html_options={})
    active = "active" if current_page?(url)
    content_tag :li, {class: active} do
      link_to body, url, class: "#{active}"
    end
  end

  def create_button(text, url, html_options={})
    mode = html_options[:mode] || 'default'
    html_options.merge! class: "btn btn-#{mode} #{html_options[:class]}"
    link_to icon(html_options[:icon], text), url, html_options
  end

  def format_date(date)
    l(date, format: :date_time)
  end
  
  def read_mode?
    action_name == 'show'
  end
end
