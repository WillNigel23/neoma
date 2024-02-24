module ApplicationHelper

  def artpieces_collection
    artpiece_collection = []

    pages = Spina::Resource.where(name: 'artworks').first&.pages

    pages&.each do |p|
      artpiece_collection << [p.id, p.content(:header)]
    end

    artpiece_collection
  end

  def main_nav_items
    @main_nav_items ||= Spina::Navigation.find_by(name: "main").navigation_items.roots.sorted
  end

  def exhibits
    @exhibits ||= Spina::Resource.find_by(name: 'exhibits').pages
  end

end
