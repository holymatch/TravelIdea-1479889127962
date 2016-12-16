module ApplicationHelper
  def nav_to(text, options)
    content = link_to_unless(current_page?(options), text.html_safe, options) do
      "<a class='nav-link' tabindex='0'>#{text}</a>".html_safe
    end
    if current_page?(options)
      content_tag(:li, content, class: ["nav-link", "active" ])
    else
      content_tag(:li, content, class: "nav-link")
    end
  end
  
  def hash_tag_link(hash_tags)
    tags = hash_tags.split(',')
    content = []
    tags.each do |t|
      #content.push(link_to( t.start_with?('#') ? t.strip : "##{t.strip}", controller: 'ideas', action: 'index', keyword: t.strip ))
      content.push(link_to( t.strip, {controller: 'ideas', action: 'index', keyword: t.strip}, {class: "label label-info"}))
    end
    content.join(', ').html_safe
  end
end
