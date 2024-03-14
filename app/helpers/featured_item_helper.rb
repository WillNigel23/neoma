# frozen_string_literal: true

module FeaturedItemHelper
  def fe_featured_item_link(link_path,
                            opts = { class: 'sticky top-5 md:top-1/4' }, &block)
    link_to(link_path, method: :get, class: opts[:class], data: opts[:data]) do
      concat(capture(&block)) if block_given?
    end
  end

  def fe_featured_item_content_wrapper(_content = nil,
                                       opts = { class: 'flex flex-col items-start justify-start' }, &block)
    content_tag(:span,
                class: opts[:class]) do
      concat(capture(&block)) if block_given?
    end
  end

  def fe_featured_item_image(spina_image,
                             opts = { class: 'transition-all duration-500 hover:scale-110 mb-5 reveal' })
    return if spina_image.nil?
    image_url = main_app.url_for(spina_image.file)

    image_tag(image_url,
              {
                class: opts[:class]
              })
  end

  def fe_featured_item_pretitle(content,
                                opts = { class: 'font-montserrat text-gray-600 text-light text-sm' })
    content_tag(:p, content, **opts)
  end

  def fe_featured_item_title(content,
                             opts = { class: 'font-restora font-bold text-xl mb-2' })
    content_tag(:h3, content, **opts)
  end

  def fe_featured_item_subtitle(content,
                                opts = { class: 'font-montserrat font-light text-sm' })
    content_tag(:p, content, **opts)
  end

  def fe_featured_item_text(content,
                            opts = { class: 'font-montserrat font-light text-sm text-gray-800' })
    content_tag(:p, content, **opts)
  end
end
