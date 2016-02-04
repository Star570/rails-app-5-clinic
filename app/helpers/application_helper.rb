module ApplicationHelper

  def font_bold_class(link_path)
    link_controller = Rails.application.routes.recognize_path(link_path)[:controller]
    link_id = Rails.application.routes.recognize_path(link_path)[:id]
    current_controller = params[:controller]
    current_id = params[:id]
    if (link_controller == current_controller) && (link_id == current_id)
      "color: black; font-weight: bold"
    else
      ""
    end
  end

  def font_black_class(link_path)
    link_action = Rails.application.routes.recognize_path(link_path)[:action]
    current_action = params[:action]
    if (link_action == current_action)
      "color: black; font-weight: bold"
    else
      ""
    end
  end

end
