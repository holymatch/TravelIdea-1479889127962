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
end
