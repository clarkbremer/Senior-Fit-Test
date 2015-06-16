module ApplicationHelper
  def age(dob)
    now = Time.now.utc.to_date
    now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
  end

  def bootstrap_class_for flash_type
    ({ success: "alert-success", error: "alert-danger", alert: "alert-warning", notice: "alert-info" }.with_indifferent_access)[flash_type] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      puts "============"
      puts bootstrap_class_for(msg_type)
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} fade in") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end
end
