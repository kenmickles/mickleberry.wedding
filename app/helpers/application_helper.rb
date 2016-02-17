module ApplicationHelper
  def body_classes
    @body_classes ||= [controller.controller_name.dasherize, controller.action_name.dasherize].join(' ')
  end

  def js_view
    action = case action_name
      when "create" then "New"
      when "update" then "Edit"
      else action_name
    end.camelize

    "Views.#{controller.class.name.gsub('::', '.').gsub(/Controller$/, '')}.#{action}View"
  end
  
  def markdown(str)
    Kramdown::Document.new(str).to_html.html_safe if str.present?
  end

  def meal_options
    @meal_options ||= Meal.all.order(:name).collect { |m| [m.name, m.id] }
  end

  def possessive(str)
    if str.match(/s$/i)
      "#{str}'"
    else
      "#{str}'s"
    end
  end
end
