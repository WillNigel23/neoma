module CarouselHelper

  def fe_carousel(_content = nil, &block)
    content_tag(:div,
      class: 'w-full h-screen swiper swiper-initialized swiper-horizontal swiper-pointer-events swiper-backface-hidden',
      data: {
        controller: 'carousel',
        carousel_options_value: '
            {
            "navigation": {
              "nextEl": ".swiper-button-next",
              "prevEl": ".swiper-button-prev"
            },
            "pagination": {
              "el": ".swiper-pagination",
              "type": "bullets"
            },
            "keyboard": {
              "enabled": "true",
              "onlyInViewport": "false"
            },
            "loop": "true",
            "effect": "fade",
            "fadeEffect": {
              "crossFade": "true"
            },
            "autoplay": {
              "delay": "5000"
            }
        }'
      }
    ) do
      concat(capture(&block)) if block.present?
    end
  end

  def fe_carousel_wrapper(_content = nil, &block)
    block = capture(&block)
    pagination = content_tag(:div, '', class: 'swiper-pagination')

    content_tag(:div, class: 'swiper-wrapper') do
      if block.present?
        concat(block + pagination)
      else
        concat(pagination)
      end
    end
  end

  def fe_carousel_item(_content = nil, &block)
    content_tag(:div, class: 'swiper-slide swiper-slide-active w-full') do
      concat(capture(&block))
    end
  end

end
