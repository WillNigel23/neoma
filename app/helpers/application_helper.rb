module ApplicationHelper

  def artpieces_collection
    artpiece_collection = []

    pages = Spina::Resource.where(name: 'artworks').first&.pages

    pages&.each do |p|
      artpiece_collection << [p.id, p.content(:header)]
    end

    artpiece_collection
  end

  def exhibits
    @exhibits ||= Spina::Resource.find_by(name: 'exhibits').pages.live
  end

end
