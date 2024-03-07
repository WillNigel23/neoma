# frozen_string_literal: true

module ApplicationHelper
  def main_nav_items
    @main_nav_items ||= Spina::Navigation.find_by(name: 'main').navigation_items.roots.sorted
  end

  def exhibits
    @exhibits ||= Spina::Resource.find_by(name: 'exhibits').pages
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
    ['Artists', 'Exhibits']
  end
end
