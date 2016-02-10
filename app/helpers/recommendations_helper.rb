module RecommendationsHelper
  def category_icon(rec)
    case rec.category
    when "restaurant"
      "<i class='fa fa-cutlery'></i>".html_safe
    when "hotel"
      "<i class='fa fa-bed'></i>".html_safe
    when "home"
      "<i class='fa fa-home'></i>".html_safe
    else
      "<i class='fa fa-map-marker'></i>".html_safe
    end
  end
end