module FormHelper

  def error_field(attribute, errors)
    content = nil
    if errors[attribute]
      content = content_tag(:div, class: 'text-red-500 font-medium text-sm px-3 flex items-center') do
        errors.full_messages_for(attribute).join(', ')
      end
    end

    content
  end

end
