module BannerHelper

  def fe_banner(_content = nil, &block)
    content_tag(:section, 
      class: 'fixed top-0 left-0 flex items-center justify-center 
        w-full h-screen overflow-hidden bg-gradient-to-t 
        from-black to-[#303030] p-0 m-0') do
      concat(capture(&block)) if block_given?
    end
  end
  
  def fe_banner_img(image_url)
    image_tag(image_url, 
      { 
        class: 'absolute top-0 left-0 w-full min-w-[1920px] 
          object-cover opacity-50'
      }
    )
  end

  def fe_banner_inner(_content = nil, &block)
    content_tag(:div,
      class: 'container mx-auto px-5 z-10 text-center', 
      data: { controller: 'scroll-reveal' }
    ) do
      concat(capture(&block)) if block_given?
    end
  end

  def fe_banner_preheader(
    content, 
    opts = {
      class: 'text-xs text-white mb-5 md:mb-16 reveal',
      data: { scroll_reveal_target: 'item', delay: '250ms' }
    } 
  )
    content_tag(:p, content, **opts)
  end

  def fe_banner_header(
    content, 
    opts = {
      class: 'font-bold text-white text-5xl md:text-7xl mb-5 uppercase reveal',
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

  def fe_banner_button(
    content,
    link_url,
    opts = {
      class: 'text-center text-white hover:text-black hover:bg-white transition-all duration-300 border border-white px-3 py-2 min-w-[120px] bg-transparent',
      data: { scroll_reveal_target: 'item', delay: '250ms' }
    }
  )
    #content_tag(:button, content, opts)
    button_to(content, link_url, **opts)
  end

end
