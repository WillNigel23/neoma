module FilterHelper

  def fe_sort_dropdown(path, selected, options, model: 'default')
    button_element = button_tag(class: 'text-xs font-medium px-4 rounded inline-flex items-center') do
      t("sorting.#{model}.#{selected}").html_safe
    end

    ul_element = content_tag(:ul, class: 'dropdown-menu absolute hidden pt-1 shadow-lg w-full') do
      options.map do |option|
        concat(content_tag(:li, class: 'text-xs bg-gray-50 hover:bg-gray-200 py-2 px-3 block whitespace-no-wrap') do
          link_to("#{path}?sort_by=#{option[0]}",
            class: 'block',
            data: { turbo: true, turbo_stream: true }) do
              t("sorting.#{model}.#{option[0]}").html_safe
            end
        end)
      end
    end

    content_tag(:div, class: 'dropdown inline-block relative min-w-[90px]') do
      button_element + ul_element
    end
  end

end
