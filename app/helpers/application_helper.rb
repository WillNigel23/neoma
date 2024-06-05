module ApplicationHelper

  def main_nav_items
    @main_nav_items ||= Spina::Navigation.find_by(name: 'main').navigation_items.roots.sorted
  end

  def scrollto_section_items(content_sections)
    items = content_sections&.map do |section|
      ["##{section.content(:header).downcase.gsub(' ', '_')}", section.content(:header)] if section.content(:header)
    end
    items = [] if items.nil?
    items
  end

  def exhibits
    @exhibits ||= Spina::Resource.find_by(name: 'exhibits').pages.live
  end

  def artworks
    @artworks ||= Spina::Resource.find_by(name: 'artworks').pages.live
  end

  def ongoing_exhibits
    ongoing = exhibits.select do |exhibit|
      exhibit.content(:end_date).present? && Date.strptime(exhibit.content(:end_date), '%d, %B %Y') >= Date.current
    end
    ongoing.sort_by! do |exhibit|
      if exhibit.content(:start_date).nil?
        [
          1,
          Date.current
        ]
      else
        [0, Date.strptime(exhibit.content(:start_date), '%d, %B %Y')]
      end
    end
    ongoing&.reverse!
  end

  def past_exhibits
    past = exhibits.select do |exhibit|
      exhibit.content(:end_date).nil? || Date.strptime(exhibit.content(:end_date), '%d, %B %Y') < Date.current
    end
    past.sort_by! do |exhibit|
      if exhibit.content(:start_date).nil?
        [
          1,
          Date.current
        ]
      else
        [0, Date.strptime(exhibit.content(:start_date), '%d, %B %Y')]
      end
    end
    past&.reverse!
  end

  def artists
    @artists ||= Spina::Resource.find_by(name: 'artists').pages.live
  end

  def galleries
    @galleries ||= Spina::Resource.find_by(name: 'galleries').pages.live
  end

  def events
    @events ||= Spina::Resource.find_by(name: 'events').pages.live
  end

  def ongoing_events
    ongoing = events.select do |event|
      event.content(:end_date).present? && Date.strptime(event.content(:end_date), '%d, %B %Y') >= Date.current
    end
    ongoing.sort_by! do |event|
      if event.content(:start_date).nil?
        [
          1,
          Date.current
        ]
      else
        [0, Date.strptime(event.content(:start_date), '%d, %B %Y')]
      end
    end
    ongoing&.reverse!
  end

  def past_events
    past = events.select do |event|
      event.content(:end_date).nil? || Date.strptime(event.content(:end_date), '%d, %B %Y') < Date.current
    end
    past.sort_by! do |event|
      if event.content(:start_date).nil?
        [
          1,
          Date.current
        ]
      else
        [0, Date.strptime(event.content(:start_date), '%d, %B %Y')]
      end
    end
    past&.reverse!
  end

  def exhibit_scroll_nav_items
    [
      ['#ongoing', 'Ongoing'],
      ['#past', 'Past']
    ]
  end

  def event_scroll_nav_items
    [
      ['#ongoing', 'Ongoing'],
      ['#past', 'Past']
    ]
  end

  def artist_scroll_nav_items
    [
      ['#list_view', 'List View'],
      ['#grid_view', 'Grid View']
    ]
  end

  def navbar_color_scheme
    ['Artists', 'Artworks', 'Exhibits', 'Galleries', 'Events']
  end

  def v2_main_nav_items
    [
      [:home, v2_root_path],
      [:exhibits, v2_exhibits_path],
      [:artworks, v2_artworks_path],
      [:artists, v2_artists_path],
      [:articles, v2_articles_path],
      [:galleries, v2_galleries_path],
      [:about, v2_root_path]
    ]
  end

  def v2_admin_content_nav_items
    [
      [:homepage, v2_admin_root_path],
      [:exhibits, v2_admin_exhibits_path]
      # [:artworks, v2_admin_artworks_path]
      # [:artists, v2_artists_path],
      # [:articles, v2_articles_path],
      # [:galleries, v2_galleries_path],
      # [:about, v2_root_path]
    ]
  end

  def v2_admin_inbox_nav_items
    [
      [:email_list, '#'],
      [:inquiries, '#']
      # [:artworks, v2_admin_artworks_path]
      # [:artists, v2_artists_path],
      # [:articles, v2_articles_path],
      # [:galleries, v2_galleries_path],
      # [:about, v2_root_path]
    ]
  end

  def v2_admin_manage_nav_items
    [
      [:users, '#']
    ]
  end

  def classes_for_flash(key)
    case key
    when :error
      'bg-neoma-pink-1 text-neoma-pink-4'
    else
      'bg-neoma-blue-1 text-white'
    end
  end

  def icons_for_flash(key)
    case key
    when :error
      content_tag(:i, nil, class: 'fa-solid fa-circle-exclamation text-neoma-pink-2 text-xl')
    else
      content_tag(:i, nil, class: 'fa-solid fa-circle-check text-neoma-blue-2 text-xl')
    end
  end

end
