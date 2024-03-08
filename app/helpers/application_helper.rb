# frozen_string_literal: true

module ApplicationHelper
  def main_nav_items
    @main_nav_items ||= Spina::Navigation.find_by(name: 'main').navigation_items.roots.sorted
  end

  def exhibits
    @exhibits ||= Spina::Resource.find_by(name: 'exhibits').pages
  end

  def ongoing_exhibits
    ongoing = exhibits.select do |exhibit|
      exhibit.content(:end_date).present? && Date.strptime(exhibit.content(:end_date), '%d, %B %Y') >= Date.current
    end
    ongoing.sort_by! do |exhibit|
      if exhibit.content(:start_date).nil?
        [1,
         Date.current]
      else
        [0, Date.strptime(exhibit.content(:start_date), '%d, %B %Y')]
      end
    end
  end

  def past_exhibits
    past = exhibits.select do |exhibit|
      exhibit.content(:end_date).nil? || Date.strptime(exhibit.content(:end_date), '%d, %B %Y') < Date.current
    end
    past.sort_by! do |exhibit|
      if exhibit.content(:start_date).nil?
        [1,
         Date.current]
      else
        [0, Date.strptime(exhibit.content(:start_date), '%d, %B %Y')]
      end
    end
  end

  def artists
    @artists ||= Spina::Resource.find_by(name: 'artists').pages
  end

  def galleries
    @galleries ||= Spina::Resource.find_by(name: 'galleries').pages
  end

  def exhibit_scroll_nav_items
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
    %w[Artists Exhibits Galleries]
  end
end
