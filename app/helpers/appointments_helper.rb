module AppointmentsHelper
  def time_options(available_hours)
    available_hours.map do |hour|
      tag_builder.content_tag_string(:option, "#{hour}:00 - #{hour + 1}:00", { value: hour })
    end.join('\n').html_safe
  end

  def datetime(appointment)
    l(appointment.datetime, format: '%d %B, %Y') + " #{appointment.datetime.hour}:00 - #{appointment.datetime.hour + 1}:00"
  end

  def pill_with_status(appointment)
    status = appointment.status

    class_name = if appointment.closed?
                   'secondary'
                 elsif appointment.past?
                   'danger'
                 else
                   'success'
                 end

    content_tag(:span, t("appointments.status.#{status}"), class: "badge bg-#{class_name}")
  end
end
