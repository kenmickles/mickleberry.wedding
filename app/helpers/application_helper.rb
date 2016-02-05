module ApplicationHelper
  def markdown(str)
    Kramdown::Document.new(str).to_html.html_safe if str.present?
  end 
end
