module ApplicationHelper

  def font_bold_class(link_path)
    link_controller = Rails.application.routes.recognize_path(link_path)[:controller]
    link_id = Rails.application.routes.recognize_path(link_path)[:id]
    current_controller = params[:controller]
    current_id = params[:id]
    if (link_controller == current_controller) && (link_id == current_id)
      "font-weight: bold"
    else
      ""
    end
  end

end
