module DeviseHelper
  def devise_error_messages!
    if resource.errors.any? && flash.empty?
      msg = resource.errors.full_messages.first

      construct_script msg
    else
      return ''
    end
  end

  def construct_script msg
    msg.gsub! "'", "`" unless msg.nil?

    html_script = "<script>toastr.error('#{msg}');</script>"

    html = <<-HTML
       #{html_script}
    HTML

    return html.html_safe
  end
end