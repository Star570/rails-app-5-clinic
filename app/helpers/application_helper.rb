module ApplicationHelper

  def notice_message
    alert_types = { notice: :success, alert: :danger }

    close_button_options = { class: "close", "data-dismiss" => "alert", "aria-hidden" => true }
    close_button = content_tag(:button, "×", close_button_options)

    alerts = flash.map do |type, message|
      alert_content = close_button + message

      alert_type = alert_types[type.to_sym] || type
      alert_class = "alert alert-#{alert_type} alert-dismissable"

      content_tag(:div, alert_content, class: alert_class)
    end

    alerts.join("\n").html_safe
  end  
  
  def font_bold_class(link_path)
    link_controller = Rails.application.routes.recognize_path(link_path)[:controller]
    link_action = Rails.application.routes.recognize_path(link_path)[:action]    
    link_id = Rails.application.routes.recognize_path(link_path)[:id]    
    current_controller = params[:controller]
    current_action = params[:action]
    current_id = params[:id]

    if ((link_controller == current_controller) && (link_id == current_id) &&
        ((link_action == current_action) || 
         (link_action == 'index' && current_action == 'show') ||
         (link_action == 'index' && current_action == 'overall')))
      "color: black; font-weight: bold"
    else
      ""
    end
  end

end
