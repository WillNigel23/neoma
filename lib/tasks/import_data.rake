require 'tempfile'
require 'open-uri'

namespace :v2 do
  desc 'Clear V2 data'
  task clear_data: :environment do
    User.destroy_all
    Article.destroy_all
    Gallery.destroy_all
    Exhibit.destroy_all
    Artwork.destroy_all
    Artist.destroy_all
    Image.destroy_all
  end

  desc 'Import from Spina to V2'
  task import_spina_to_v2: :environment do
    ActiveRecord::Base.transaction do
      import_artists
      import_artworks
      import_exhibits
      import_galleries
      import_articles
    end
  end

  def import_image(spina_image)
    return nil if spina_image.nil?

    downloaded_image = URI.open(spina_image.file.url)

    image = Image.new

    image.file.attach(
      io: downloaded_image,
      filename: spina_image.file.filename,
      content_type: spina_image.file.content_type
    )

    image.save

    image
  end

  def import_artists
    spina_artists = Spina::Resource.find_by(name: 'artists').pages

    spina_artists.each do |spina_artist|
      import_artist(spina_artist)
    end
  end

  def import_artist(spina_artist)
    artist = Artist.find_or_create_by(name: spina_artist.content(:header))

    artist.description = spina_artist.content(:subheader)
    artist.role        = spina_artist.content(:role)
    artist.status      = spina_artist.live? ? :live : :draft
    artist.banner_id   = import_image(spina_artist.content(:banner).spina_image)&.id
    artist.portrait_id = import_image(spina_artist.content(:portrait).spina_image)&.id

    build_content_sections(artist, spina_artist.content(:section))

    artist.save
  end

  def import_artworks
    spina_artworks = Spina::Resource.find_by(name: 'artworks').pages

    spina_artworks.each do |spina_artwork|
      import_artwork(spina_artwork)
    end
  end

  def import_artwork(spina_artwork)
    artwork = Artwork.find_or_create_by(title: spina_artwork.content(:header))

    # To extract description from body
    description_pattern = %r{<blockquote>(.*?)</blockquote>}

    match_description = spina_artwork.content(:body).match(description_pattern)

    if match_description
      description = match_description[1]
    else
      description = nil
    end

    # To extract data from body
    data_pattern = %r{<em>(.*?) \| (.*?) \| (\d{4})</em>}
    match_data = spina_artwork.content(:body).match(data_pattern)

    if match_data
      size = match_data[1]
      medium = match_data[2]
      year = match_data[3]
    else
      size = nil
      medium = nil
      year = nil
    end

    artwork.description = description
    artwork.medium      = medium
    artwork.size        = size
    artwork.year        = year.to_s

    artwork.price       = spina_artwork.content(:price).gsub(/[₱, ]/, '').to_i
    artwork.artist_id   = Artist.find_by(name: spina_artwork.content(:featured_artist)[0].content(:header))&.id
    artwork.status      = spina_artwork.live? ? :live : :draft
    artwork.image_id    = import_image(spina_artwork.content(:image).spina_image)&.id

    artwork.save
  end

  def import_exhibits
    spina_exhibits = Spina::Resource.find_by(name: 'exhibits').pages

    spina_exhibits.each do |spina_exhibit|
      import_exhibit(spina_exhibit)
    end
  end

  def import_exhibit(spina_exhibit)
    exhibit = Exhibit.find_or_create_by(title: spina_exhibit.content(:header))

    exhibit.subtitle      = spina_exhibit.content(:subheader)
    exhibit.description   = spina_exhibit.content(:summary)
    exhibit.start_date    = Time.parse(spina_exhibit.content(:start_date))
    exhibit.end_date      = spina_exhibit.content(:end_date).blank? ? nil : Time.parse(spina_exhibit.content(:end_date))
    exhibit.status        = spina_exhibit.live? ? :live : :draft
    exhibit.banner_id     = import_image(spina_exhibit.content(:banner).spina_image)&.id
    exhibit.poster_id     = import_image(spina_exhibit.content(:poster).spina_image)&.id

    artwork_ids = []
    spina_exhibit.content(:featured_artworks)[1].each do |spina_artwork|
      title = spina_artwork.content(:header)
      artwork = Artwork.find_by(title:)
      artwork_ids << artwork.id if artwork
    end

    exhibit.artwork_ids = artwork_ids

    build_content_sections(exhibit, spina_exhibit.content(:section))

    exhibit.save
  end

  def import_galleries
    spina_galleries = Spina::Resource.find_by(name: 'galleries').pages

    spina_galleries.each do |spina_gallery|
      import_gallery(spina_gallery)
    end
  end

  def import_gallery(spina_gallery)
    gallery = Gallery.find_or_create_by(title: spina_gallery.content(:header))

    gallery.description = spina_gallery.content(:summary)
    gallery.location    = spina_gallery.content(:subheader)
    gallery.status      = spina_gallery.live? ? :live : :draft
    gallery.banner_id   = import_image(spina_gallery.content(:banner).spina_image)&.id

    build_content_sections(gallery, spina_gallery.content(:section))

    gallery.save
  end

  def import_articles
    spina_articles = Spina::Resource.find_by(name: 'events').pages

    spina_articles.each do |spina_article|
      import_article(spina_article)
    end
  end

  def import_article(spina_article)
    return if spina_article.content(:start_date).blank?

    article = Article.find_or_create_by(title: spina_article.content(:header))

    article.description = spina_article.content(:summary)
    article.date        = Time.parse(spina_article.content(:start_date))
    article.subtitle    = spina_article.content(:subheader)
    article.status      = spina_article.live? ? :live : :draft
    article.banner_id   = import_image(spina_article.content(:banner).spina_image)&.id

    build_content_sections(article, spina_article.content(:section))

    article.save
  end

  def build_content_sections(object, spina_content_sections)
    spina_content_sections.each_with_index do |spina_content_section, position|
      content_section = object.content_sections.new

      content_section.header = spina_content_section.content(:header)
      content_section.position = position
      content_section.content.body = spina_content_section.content(:body)

      content_section.save

      spina_content_section.content(:carousel)&.each_with_index do |carousel_image, image_position|
        image = import_image(carousel_image.spina_image)

        next if image.nil?

        content_section.content_images.create(image_id: image.id, position: image_position)
      end
    end
  end
end
