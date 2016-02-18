module ApplicationHelper
  def markdown(content)
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
    options = {
      autolink: true,
      no_intra_emphasis: true,
      disable_indented_code_blocks: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrought: true,
      superscript: true
    }

    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end

  def show_time_slot(time_slot)
    "#{time_slot/2}:#{time_slot%2*3}0"
  end

  def show_phone(phone)
    "#{phone[0..3]}-#{phone[4..6]}-#{phone[7..9]}"
  end  

  def show_date(date)
    date.strftime("%Y-%m-%d") 
  end  

  def show_datetime(datetime)
    datetime.in_time_zone("Taipei").strftime("%Y-%m-%d %H:%M")
  end    

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

    if ((link_controller == current_controller) && (link_id == current_id) && (link_action == current_action))
      "color: black; font-weight: bold"
    else
      ""
    end
  end

  def font_bold_class_check_pages_controller
    link_controller = "pages"
    current_controller = params[:controller]
    current_action = params[:action]

    if ((link_controller == current_controller) || 
        (current_controller == 'users' && current_action == 'show') || 
        (current_controller == 'announcements' && current_action == 'new') || 
        (current_controller == 'posts' && current_action == 'new'))
      "color: black; font-weight: bold"
    else
      ""
    end
  end

end
