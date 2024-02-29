# frozen_string_literal: true

module ApplicationHelper
  def main_nav_items
    @main_nav_items ||= Spina::Navigation.find_by(name: 'main').navigation_items.roots.sorted
  end

  def exhibits
    @exhibits ||= Spina::Resource.find_by(name: 'exhibits').pages
  end

  def galleries
    @galleries ||= Spina::Resource.find_by(name: 'galleries').pages
  end
end
