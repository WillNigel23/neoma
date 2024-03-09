# frozen_string_literal: true

module BannerHelper
  def fe_banner(_content = nil, &block)
    content_tag(:section,
                class: 'sticky top-0 left-0 flex items-center justify-center
        w-full h-screen overflow-hidden bg-gradient-to-t
        from-black to-[#303030] p-0 m-0 z-20') do
      concat(capture(&block)) if block_given?
    end
  end

  def fe_banner_img(spina_image, opts = {})
    opacity = opts[:opacity] || '.2'

    image_url = main_app.url_for(spina_image.file)
    image_tag(image_url,
              {
                class: 'absolute top-0 left-0 w-full w-[100vw] min-h-[100vh]
          object-cover',
                style: "opacity: #{opacity};"
              })
  end

  def fe_banner_inner(_content = nil, &block)
    content_tag(:div,
                class: 'container mx-auto px-5 z-10 text-center',
                data: { controller: 'scroll-reveal' }) do
      concat(capture(&block)) if block_given?
    end
  end

  def fe_banner_preheader(
    content,
    opts = {
      class: 'text-xs text-white mb-5 reveal',
      data: { scroll_reveal_target: 'item', delay: '250ms' }
    }
  )
    content_tag(:p, content, **opts)
  end

  def fe_banner_header(
    content,
    opts = {
      class: 'font-bold text-white text-3xl sm:text-5xl md:text-7xl mb-5 uppercase reveal',
      data: { scroll_reveal_target: 'item', delay: '250ms' }
    }
  )
    content_tag(:h3, content, **opts)
  end

  def fe_banner_subheader(
    content,
    opts = {
      class: 'font-light text-white text-normal md:text-xl mb-5 reveal',
      data: { scroll_reveal_target: 'item', delay: '250ms' }
    }
  )
    content_tag(:p, content, **opts)
  end

  def fe_banner_link(
    content,
    link_url,
    opts = {
      class: 'text-center text-black transition-color duration-500 bg-neoma-pink-1 hover:bg-[#f7b1af] px-3 py-2 min-w-[120px]',
      data: { scroll_reveal_target: 'item', delay: '250ms' }
    }
  )
    content_tag(:span,
                link_to(content, link_url, { class: opts[:class] }),
                { class: 'reveal', class: opts[:data] })
  end
end
