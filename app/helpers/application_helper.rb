module ApplicationHelper
  def body_classes
    @body_classes ||= [controller.controller_name.dasherize, controller.action_name.dasherize].join(' ')
  end
  
  def markdown(str)
    Kramdown::Document.new(str).to_html.html_safe if str.present?
  end
end
